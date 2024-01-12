# ab-testing-in-ruby

Title: How to implement A/B testing in Ruby using ConfigCat Feature Flags.
Description: A step-by-step guide on how to Implement A/B Testing in Ruby using ConfigCat Feature Flags and Amplitude Data Analytics Platform

## Introduction

Conducting an A/B Test experiment is a great way to find out what version of a feature works best for your users. It is a method that is essential to the success of any product and business. Implementing it can be a bit tricky and time consuming, but it doesn't have to be if the right tools are used. Coming up, for the Ruby developers out there, I'll show you how to conduct an A/B test experiment in Ruby using ConfigCat Feature Flags and Record the results with Amplitude Data Analytics Platform. Let's get started!

## Overview - Getting familiar with the concepts

### What is A/B Testing?

<!-- TODO: Explain A/B testing using a simple analogy -->

Picture a scenario where you are a founder at a new mobile app tech startup and you're looking to increase the number of users that sign up for your app. Your have team presented you with two landing page designs that you plan to deploy to collect user signups. One of the designs has a blue colored Call to action button and the other has a red colored Call to action button. You're not sure which one will work best for your users. This is where an A/B test experiment comes in useful. 

An A/B test experiment is a method of comparing two versions of something to figure out which one performs better. In this case, we want to know which version of the landing page will result in more user signups. To do this, we'll need to deploy the two versions of the landing page, one with the blue CTA button and the other with the CTA red button. We'll then show each version to
two different groups of users and track the number of signups from each group. The version with the highest number of signups wins.

<!-- todo: Show the two versions side by side  -->


### How does feature flagging work?

<!-- TODO: How can feature flags help us prove the hypothesis -->

<!-- TODO: Introduce ConfigCat as a Feature flag provider -->


### What is Amplitude?

<!-- TODO: Talk about the role amplitude play. Recording, Collecting and analyzing test results -->


## Prerequisites

Here are the things you'll need to get started and follow along:

- A free account on [ConfigCat](https://configcat.com/)
- A free account on [Amplitude](https://amplitude.com/)
- Latest version of [Ruby](https://www.ruby-lang.org/en/downloads/) installed on your machine
- A text editor of your choice. I'll be using [VSCode](https://code.visualstudio.com/download) for this tutorial
- Basic knowledge of Ruby and Sinatra

## Live Demo

<!-- TODO: Image of the two versions side by side -->

<!-- TODO: Add code snippet that represents the buttons -->


<!-- TODO: Explain how feature flags can be used to show one of the buttons and hide
the other when the feature flag saved -->

### Adding the feature flag

<!-- TODO: Creating a ConfigCat account -->

<!-- TODO: Add the relevant images -->

### Updating the code

<!-- TODO: Update the code to include the feature flag that was created -->

<!-- todo: talk about switching between version a/b -->

### User segmentation and targeting

<!-- todo: explain the importance of segmentation in a/b testing. -->

<!-- todo: mention that we need two user groups for showing each version to 
. I'll decide on the user groups based on the user's country
I'll show the white button (Version A) to users in the France and the red button (Version B) to users in Hungary.

 -->

<!-- todo: segway into configuring segmentation in the ConfigCat -->


### User Object

<!-- todo: for cc to know which country the user is from, i'll need to send details about the user in a User Object. Here is how the user object looks like 

-->
### Did it work?

<!-- todo: show switching between the two version by updating the country's value in the User Object 

mention that this is a good way to see if the feature flag is working as expected. 

-->

### Tracking the results with Amplitude

<!-- todo: setting up amplitude

- Creating an account

- Creating an organization

- Creating a project

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


Here we're going to use a simple framework called Sinatra to create a simple landing page with a blue colored Call to action button. We will use ConfigCat to change the color of the button to red and track the conversion rate of the two variants with Amplitude.


## Getting started with Amplitude

1. Create a free account on [Amplitude](https://amplitude.com/)


2. On the home page, which should have the following url: <https://app.amplitude.com/analytics/YOUR-USERNAME/home>

3. Create a new project, Navigate to your organization settings by clicking on the gear icon at the top right corner of the page, then click on the "Projects" in the left sidebar. Click on the "New Project" button to create a project with the following details:

<!-- Add image: Creating a new project on Amplitude -->

4. Select the data source and SDK to use. In this case case, we'll be using the browser SDK.

<!-- TD: Add image here -->

5. To view the click events from each button on the landing page, we'll need to create a chart to visualize the clicks from each button. Click the "Create" button on the top left corner and select "Chart":

<!-- TODO: Add image of sidebar for creating a new chart -->

6. Choose "Segmentation" so that the chart can segment events based on filters and metrics.



## Run the app

```sh
ruby landing_page.rb
```