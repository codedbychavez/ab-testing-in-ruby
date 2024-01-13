# ab-testing-in-ruby

Title: How to implement A/B testing in Ruby using ConfigCat Feature Flags.
Description: A step-by-step guide on how to Implement A/B Testing in Ruby using ConfigCat Feature Flags and Amplitude Data Analytics Platform

## Introduction

Conducting an A/B Test experiment is a popular method used to determine what version of a particular feature works best for your users. It is an experiment that can shape the success of any product or business. Conducting it can be a bit tricky and time consuming, but it doesn't have to be if the right tools are used. Coming up, for the Ruby developers out there, I'll show you how to perform an A/B test experiment in Ruby using ConfigCat feature flags and record the results with Amplitude data analytics platform. Let's get started!

## Overview - Getting familiar with the concepts

Let's take a look at the concepts we'll be working with.

### What is A/B Testing?

Think of a scenario where you are a founder at a new tech startup and you're looking to encourage users to download your mobile app via a landing page. Your team presented you with two designs. One of the designs has a white colored call to action button, lets call this "Version A" and the other has a red, lets call this "Version B", but you're not sure which version to choose. This is where an A/B test experiment comes in useful.

An A/B test experiment is a method of comparing two versions of something to figure out which one performs better. In this case, you want to know which version of the landing page will yield more user downloads. To do this, you'll need to deploy both versions of the landing page. Each version will be shown to
two different groups of users. Then setup tracking to record the the number of downloads from each group. The version with the highest number of downloads wins and can be deployed to all users.

<!-- image: Show the two versions side by side  -->

To deploy both versions of the landing page, you'll need to create a feature flag.

### How do feature flags work?

A feature flag is merely a boolean value that can be used to turn a feature on or off. In this case, we'll use a feature flag to show each group a different version of the landing page. This means that one group will see version A and the other will see version B. One of the primary benefits of using a feature flag is that is it allows this to be done without having to redeploy the app. This is a huge time saver.

<!-- link: add back links below -->
To get the most out of feature flags, you'll need a feature flag provider. While there are many out there, my personal favorite is [ConfigCat](https://configcat.com/). Its both easy to use, has a generous free tier, and an intuitive user dashboard. ConfigCat also has a great [Ruby SDK](https://configcat.com/docs/sdk-reference/ruby/) that we'll be using to implement feature flagging in the Ruby code that powers the landing page.

But how to record and track which version of the landing page is performing better? This is where Amplitude's data analytics platform comes in.

### What is Amplitude?

Amplitude is a data analytics platform that allows you to track user behavior and analyze the results. We'll use Amplitude to track the number of user downloads influenced by each version of the landing page. We'll also use it to analyze and visualize the results. While most of the design of both versions of the landing page is consistent with the exception of the color of the call to action button, I'll set up an event tracker on each button. Version A's button will send an event called `WHITE_CTA_BUTTON_CLICKED` and Version B's button will send an event called `RED_CTA_BUTTON_CLICKED`. More on this later.

Before diving into the code, let take a look at the resources we'll need to get started.

## Prerequisites

Here are the things you'll need to follow along:

- A free account on [ConfigCat](https://app.configcat.com/auth/signup)
- A free account on [Amplitude](https://amplitude.com/)
- Latest version of [Ruby](https://www.ruby-lang.org/en/downloads/) installed on your machine.
- A text editor of your choice. I'll be using [VSCode](https://code.visualstudio.com/download) for this demo.
- Basic knowledge of [Ruby](https://www.ruby-lang.org/en/) and [Sinatra](https://sinatrarb.com/)

## Live Demo

Now that we have all the resources we need, let's conduct a demo A/B test experiment together.

<!-- image: of the two versions side by side -->

<!-- todo: add links to documentation, user segmentation -->
With the power of feature flags and user segmentation, to end-users each version will appear as if each versions is released from two separate code bases. Here is a snippet of the code that makes this possible using an If/Else statement to show one of the buttons and hide the other based on the value of the feature flag:

```html
<div class="cta-button-wrapper">
    <% if @is_my_feature_flag_enabled %>
        <button class="button red-button" id="redCTAButton" onclick="trackRedCTAButtonClick()">Download Now</button>
    <% else %>
        <button class="button white-button" id="whiteCTAButton" onclick="trackWhiteCTAButtonClick()">Download Now</button>
    <% end %>
</div>
```

### Starter code

<!-- todo: add link to starter code here, ConfigCat code sample repo -->
To follow along, you can clone the starter code from [here](''). As we explore the upcoming parts in this section, I'll point out the relevant parts of the code to update.

### Setting up the landing page

1. Install the Gemfile dependencies by executing the following command in the terminal from the root directory:

```sh
bundle install
```

2. Check to see if the app is running by executing the following command:

```sh
ruby app.rb
```

3. Create a `.env` file in the root directory with the following environment variables:

<!-- todo: check to see if the app runs with the env content in tfh following state -->
```sh
AMPLITUDE_API_KEY="YOUR-AMPLITUDE-API-KEY-GOES-HERE"
CONFIGCAT_SDK_KEY="YOUR-CONFIGCAT-SDK-KEY-GOES-HERE"
```

If all goes well, you should be able to see the landing page at <http://localhost:4567/>

### Adding the feature flag

1. Create a free account on [ConfigCat](https://app.configcat.com/auth/signup)

2. Create a feature flag with the following details:

- Name: `my-feature-flag`
- Key: `myfeatureflag`
- Hint: `Switches between white or red CTA button`

<!-- links: add back links -->
3. Copy your ConfigCat SDK key by clicking the **View SDK Key** button in the top right corner of the dashboard or by opening the following url in a new tab: <https://app.configcat.com/sdkkey> and paste it in the `.env` file.

4. To create the two user groups, we'll need to create two user segments. This can be done by clicking the **target segment** button then selecting **Manage segments** from the dropdown menu:

<!-- image: clicks-to-create-user-segments -->

Create two user segments with the following details:

<!-- image: combined edits of user segments from cc dashboard -->

Based on the user segments created, users in Hungary (Group A) will see Version A (white CTA button) and users in France (Group B) will see Version B (red CTA button). To make this possible, we'll need to update the code to include the feature flag.

### Integrating the feature flag into the Ruby code

Update the code to include the feature flag. Here is how the code in `app.rb` should look like:

```ruby
# app.rb
require 'configcat'

# ...

# ConfigCat client initialization
configcat_client = ConfigCat.get(
  ENV['CONFIGCAT_SDK_KEY']
)

get '/' do
  # Create a variable to store the value of the feature flag
  @is_my_feature_flag_enabled = configcat_client.get_value('myfeatureflag', false)
  erb :index
end
```

### User Object

For cc to know which version to show a specific version to, it will need to know what country the user is from, This can be done by sending attributes about the user in a User Object. Let's add a user object to the code:

```ruby
# app.rb

# ...

# Create a user object to identify the user
user_object = ConfigCat::User.new(
  '7b8c03a6-502d-4d6b-8d67-fc5e1a2b9a94',
  email: 'john@example',
  country: 'France',
)

get '/' do
  # Create a variable to store the value of the feature flag
  @is_my_feature_flag_enabled = configcat_client.get_value('myfeatureflag', false, user_object)
  erb :index
end

```

### Did it work?

A good way to see if the feature flag and user segment is working as expected is to update the country in the user object.

When France is set as the country, you should see Version B (red CTA button):

<!-- image: of version B -->

When Hungary is set as the country, you should see Version A (white CTA button):

<!-- image: of version A -->

But there is one more thing we need to do. We need to track the number of clicks from each button. This is where Amplitude comes in. Lets take a look at how to set it up.

### Tracking the results with Amplitude

1. Create a free account on [Amplitude](https://amplitude.com/)

2. On the home page, which should have the following url: <https://app.amplitude.com/analytics/YOUR-USERNAME/home>, navigate to your **Organization settings** by clicking on the gear icon at the top right corner of the page, Click on the **Projects** in the left sidebar, then click **Create Project** button to create a project:

<!-- image: create-new-project-in-amplitude -->

4. Select the data source and SDK to use. In this case case, we'll be using the browser SDK.

<!-- image: select-data-source-sdk -->

5. To view the click events from each button on the landing page, we'll need to create a chart to visualize the clicks from each button. Click the "Create" button on the top left corner and select "Chart":

<!-- image: amplitude-creating-a-new-chart -->

6. Select "Segmentation" so that the chart can segment events based on filters and metrics.

<!-- image: amplitude-select-segmentation -->

7. Copy your Amplitude API key from the project settings page and paste it in the `.env` file.

8. Add two script tags to the head of `index.erb` file to link to the Amplitude SDK and initialize it with your Amplitude API key:

```html
  <head>
    <!-- ... -->
    <script type="text/javascript" src="https://cdn.amplitude.com/libs/amplitude-7.2.1-min.gz.js"></script>
    <script type="text/javascript">
      amplitude.getInstance().init("<%= ENV['AMPLITUDE_API_KEY'] %>");
    </script>
  </head>
```

9. Before the closing body tag, add the following script for tracking the clicks from each button:

```html
<body>
    <script type="text/javascript">
      function trackWhiteCTAButtonClick() {
        amplitude.getInstance().logEvent('WHITE_CTA_BUTTON_CLICKED');
      }
      function trackRedCTAButtonClick() {
        amplitude.getInstance().logEvent('RED_CTA_BUTTON_CLICKED');
      }
    </script>
    </body>
```

From the above you can see that the white button will send an event called `WHITE_CTA_BUTTON_CLICKED` and the red button will send an event called `RED_CTA_BUTTON_CLICKED`. This is how we'll be able to differentiate the clicks from each button.

<!-- todo: add the link to the index.erb file here from the configcat code sample repo -->
The complete code for `index.erb` can be found [here]('').

#### Viewing the results in Amplitude

Modify the the user object so that the country is set to Hungary, click the white button five times. Do the same for France and the red button. If all goes well, you should see both events in Amplitude.

Keep in mind that it may take a few minutes for the events to show up in Amplitude and you'll need to select the correct options in the left sidebar to see the events as shown below:

<!-- image: amplitude-chart-ab-comparison -->

Based on the results of the chart, we can see that the red button has a higher conversion rate than the white button. This means that the red button is more effective at getting users to click on it. This is a good indicator that the red button is the better option and version B should be the one to be deployed to all users.

## Conclusion

In this tutorial, we learned how to implement A/B testing in Ruby using ConfigCat Feature Flags and Amplitude Data Analytics Platform. We learned how to create a feature flag in ConfigCat, how to segment users into groups, how to integrate the feature flag into the Ruby code, and how to track the results with Amplitude. We also learned how to use the results to make a decision on which version of the landing page to deploy to all users.

If you decide to tinker and try implementing this on your own, I'd recommend signing up for a [free account on ConfigCat](https://app.configcat.com/auth/signup) and [Amplitude](https://amplitude.com/). ConfigCat has a generous free tier that allows you to start using feature flags for free.

stay on top of the latest posts and announcements from ConfigCat on [X](https://twitter.com/configcat), [Facebook](https://www.facebook.com/configcat), [LinkedIn](https://www.linkedin.com/company/configcat/), and [GitHub](https://github.com/configcat).
