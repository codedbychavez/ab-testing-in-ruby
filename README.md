# ab-testing-in-ruby

How to Implement A/B Testing in Ruby with ConfigCat Feature Flags and Amplitude Data Analytics Platform

## Introduction

Conducting an A/B Test experiment is a great way to determine how a specific version of a feature resonates with your users. Its is one way 

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