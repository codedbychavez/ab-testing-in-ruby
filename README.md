# ab-testing-in-ruby

Title: How to implement A/B testing in Ruby using ConfigCat Feature Flags.
Description: A step-by-step guide on how to Implement A/B Testing in Ruby using ConfigCat Feature Flags and Amplitude Data Analytics Platform

## Introduction

Conducting an A/B Test experiment is a great way to find out what version of a feature works best for your users. It is a method that is essential to the success of any product and business. Implementing it can be a bit tricky and time consuming, but it doesn't have to be if the right tools are used. Coming up, for the Ruby developers out there, I'll show you how to conduct an A/B test experiment in Ruby using ConfigCat Feature Flags and Record the results with Amplitude Data Analytics Platform. Let's get started!

## Overview - Getting familiar with the concepts

### What is A/B Testing?

Picture a scenario where you are a founder at a new mobile app tech startup and you're looking to increase the number of users that sign up for your app. Your have team presented you with two landing page designs that you plan to deploy to collect user signups. One of the designs has a white colored Call to action button and the other has a red colored Call to action button. You're not sure which one will work best for your users. This is where an A/B test experiment comes in useful.

An A/B test experiment is a method of comparing two versions of something to figure out which one performs better. In this case, we want to know which version of the landing page will result in more user signups. To do this, we'll need to deploy the two versions of the landing page, one with the white CTA button and the other with the CTA red button. We'll then show each version to
two different groups of users and track the number of signups from each group. The version with the highest number of signups wins.

<!-- image: Show the two versions side by side  -->

### How do feature flags work?

To put the test into action and prove the hypothesis, we'll need a way to show each version of the landing page to two different groups of users. This is where feature flags come in handy. We can use a feature flag to control which version of the landing to show to each group of users. A feature flag is merely a boolean value that can be used to turn a feature on or off. In this case, we'll use a feature flag to turn on the white CTA button for one group of users and the red CTA button for the other group of users. One of the primary benefits of using a feature flag would all us to switch between each version without having to redeploy the app. This is a huge time saver.

To get the most out of feature flags, we'll need a feature flag provider. There are many out there, but my personal favorite is [ConfigCat](https://configcat.com/). Its both easy to use, has a generous free tier, and powerful. ConfigCat also has a great [Ruby SDK](https://configcat.com/docs/sdk-reference/ruby/) that we'll be using to implement feature flagging on the landing page.

But how do we know which version of the landing page is performing better? This is where Amplitude comes in.

### What is Amplitude?

Amplitude is a data analytics platform that allows you to track user behavior and analyze the results. We'll use Amplitude to track the number of signups coming from each group of users and visualize the results. Because we're narrowing down our focus on the amount of signup clicks influenced by the color of the CTA button, we'll need to track the number of clicks from each button. This can be done by adding an event listener to each button that sends a click event to Amplitude when the button is clicked. The name of the event coming from each button would be different so that we can differentiate clicks from each button. Version A's button will send an event called `WHITE_CTA_BUTTON_CLICKED` and Version B's button will send an event called `RED_CTA_BUTTON_CLICKED`.

Before diving into the code, let take a look at the resources we'll need to get started.

## Prerequisites

Here are the things you'll need to get started and follow along:

- A free account on [ConfigCat](https://configcat.com/)
- A free account on [Amplitude](https://amplitude.com/)
- Latest version of [Ruby](https://www.ruby-lang.org/en/downloads/) installed on your machine
- A text editor of your choice. I'll be using [VSCode](https://code.visualstudio.com/download) for this tutorial
- Basic knowledge of [Ruby](https://www.ruby-lang.org/en/) and [Sinatra](https://sinatrarb.com/)

## Live Demo

Now that we have all the resources we need, let's take a look at the live demo of the landing page. Here is a side by side comparison of the two versions of the landing page:

<!-- image: of the two versions side by side -->

<!-- todo: add links to documentation -->
With the power of a feature flag and user segmentation, we can simply have a single code base, but to users in different countries, it will appear as if there are two different versions of the landing page. Here is a snippet of the code that makes this possible using an If/Else statement to show one of the buttons and hide the other:

```html
<div class="cta-button-wrapper">
    <% if @is_my_feature_flag_enabled %>
        <button class="button white-button" id="whiteCTAButton" onclick="trackWhiteCTAButtonClick()">Download Now</button>
    <% else %>
        <button class="button red-button" id="redCTAButton" onclick="trackRedCTAButtonClick()">Download Now</button>
    <% end %>
</div>
```

### Starter code

<!-- todo: Add link to starter code here -->
To follow along, you can clone the starter code from [here](''). As we explore the upcoming parts in this section, I'll point out the relevant parts of the code to update.

### Setting up the landing page

1. Install the Gemfile dependencies by running the following command in the terminal in the root directory of the repo:

```sh
bundle install
```

2. Check to see if the app is running by running the following command in the terminal in the root directory of the repo:

```sh
ruby app.rb
```

3. Create a `.env` file in the root directory of the repo and add the following environment variables:

```sh
AMPLITUDE_API_KEY="YOUR-AMPLITUDE-API-KEY-GOES-HERE"
CONFIGCAT_SDK_KEY="YOUR-CONFIGCAT-SDK-KEY-GOES-HERE"
```

If all goes well, you should be able to see the landing page at <http://localhost:4567/>

### Adding the feature flag

1. Create a free account on [ConfigCat](https://app.configcat.com/auth/signup)

2. Create a feature flag with the following details:

<!-- image: add the relevant images -->

3. Copy your ConfigCat SDK key by clicking the **View SDK Key** button in the top right corner of the dashboard.

4. To create the two user groups, we'll need to create two user segments. This can be done by clicking the **target segment** button then selecting **Manage segments** from the dropdown menu:

<!-- image: clicks-to-create-user-segments -->

Create two user segments with the following details:

<!-- image: combined edits of user segments from cc dashboard -->

Users in Hungary (Group A) will see Version A (white CTA button) and users in France (Group B) will see Version B (red CTA button). To make this possible, we'll need to update the code to include the feature flag.

### Integrating the feature flag into the Ruby code

Now that we have the feature flag created, we'll need to update the code to include the feature flag. Here is how the code will `app.rb` file will look like:

```ruby
# app.rb

# ...

# ConfigCat client initialization
configcat_client = ConfigCat.get(
  ENV['CONFIGCAT_SDK_KEY_GOES_HERE']
)

get '/' do
  # Create a variable to store the value of the feature flag
  @is_my_feature_flag_enabled = configcat_client.get_value('myfeatureflag', false, user_object)
  erb :index
end
```

### User Object

For cc to know which version to show a specific version to, it will need to know what country the user is from, This can be done by sending attributes about the user in a User Object. Let's add a user object to the code:

```ruby
# app.rb

# ...

# ConfigCat client initialization
configcat_client = ConfigCat.get(
  ENV['CONFIGCAT_SDK_KEY']
)


# Create a user object to identify the user
user_object = ConfigCat::User.new(
  '7b8c03a6-502d-4d6b-8d67-fc5e1a2b9a94',
  email: 'john@example',
  country: 'France',
)

# ...

```

### Did it work?

This is a good way to see if the feature flag is working as expected. If all goes well, you should see the two versions of the landing page when you update the country in the user object.

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

9. Before the closing body tag, add the following scripts for tracking the clicks from each button:

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

<!-- todo: add the link to the index.erb file here from the configcat code sample repo -->
The complete code for `index.erb` can be found [here]('').



<!-- todo:

- Adding the SDK to the project

- Creating a chart to visualize the results

- Sending the results to amplitude

- Viewing the results on amplitude, filtering by uniques

- How to know which version is better

 -->

## Best practices and tips

## Conclusion

<!-- todo: call to action -->

### Other stuff

<!-- TODO: May need to reuse the Amplitude stuff below -->

Here we're going to use a simple framework called Sinatra to create a simple landing page with a white colored Call to action button. We will use ConfigCat to change the color of the button to red and track the conversion rate of the two variants with Amplitude.

## Run the app

```sh
ruby landing_page.rb
```
