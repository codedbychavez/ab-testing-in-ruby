# How to implement an A/B test in Ruby using Feature Flags

## [Read the blog post here](https://configcat.com/blog/)

This repository contains the accompanying sample code for the blog article titled 'How to Implement an A/B Test in Ruby Using Feature Flags.' The application relies on the Sinatra gem to serve the landing page through the browser. To conduct the A/B test experiment, I've integrated [ConfigCat feature flags](https://configcat.com) for switching between and deploying each version to different user groups. Additionally, I've incorporated the Amplitude data analytics platform to analyze the impact of each version, to select the best one for deployment.

## Getting started

### Prerequisites

- Latest version of [Ruby](https://www.ruby-lang.org/en/downloads/) installed on your machine.
- A text editor of your choice. I'll be using [VSCode](https://code.visualstudio.com/download) for this demo.
- Basic knowledge of [Ruby](https://www.ruby-lang.org/en/) and [Sinatra](https://sinatrarb.com/)

### Build

1. Clone this repository
2. Create a `.env` file in the root of the repo with the following content. Then replace the placeholder values with your own:

```sh
AMPLITUDE_API_KEY="YOUR-AMPLITUDE-API-KEY-GOES-HERE"
CONFIGCAT_SDK_KEY="YOUR-CONFIGCAT-SDK-KEY-GOES-HERE"
```

3. Install the Gemfile dependencies:

```sh
bundle install
```

### Run

Execute the following command to launch the app in your browser:

```sh
ruby app.rb
```

The app should now be visible at: <http://localhost:4567>

## Learn more

Useful links to technical resources.

- [Ruby Documentation](https://www.ruby-lang.org/en/) - learn more about Ruby
- [Learn Sinatra](https://sinatrarb.com/intro.html) - Get started with Sinatra

[**ConfigCat**](https://configcat.com) also supports many other frameworks and languages. Check out the full list of supported SDKs [here](https://configcat.com/docs/sdk-reference/overview/).

You can also explore other code samples for various languages, frameworks, and topics here in the [ConfigCat labs](https://github.com/configcat-labs) on GitHub.

Keep up with ConfigCat on [Twitter](https://twitter.com/configcat), [Facebook](https://www.facebook.com/configcat), [LinkedIn](https://www.linkedin.com/company/configcat/), and [GitHub](https://github.com/configcat).

## Author
[Chavez Harris](https://github.com/codedbychavez)

## Contributions
Contributions are welcome!
