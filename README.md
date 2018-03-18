# RadCommon
This is a common set of features and tools tailored for a standard business web app.

## Main Features
1. common email template
1. views and helpers
1. other utilities

## Usage

### Server
To install rad_common, you must run the generator: 

`rails g rad_common:install`

This will then create the initializer in the /config/initializers directory with the default values set within the generator template as well as copy all the files to the project.

Emails are sent in the background so make sure you have a mailers queue running in sidekiq.

### Email Template
To use the common email template in your Rails project, just have your mailer subclass RadbearMailer.

## Development

### Configuring
Add a .env file in `spec/dummy` containing the `AUTHY_API_KEY` that can be obtained by creating an authy app or from another developer

### Running
`bundle exec rails s`

`bundle exec rails c`

### Test Suite

To generate items related to the dummy app, first cd into the /spec/dummy directory, then you can run `rails generate` commands.

This project contains a "dummy" app to run test against, see /spec/dummy. To prepare the test database, run the following command:

`rake app:db:migrate`
`rake app:db:test:prepare`

To run the test suite, run the following command:

`bundle exec rspec --exclude-pattern 'spec/dummy/lib/**/*_spec.rb'`

### Point Projects to Local Source Instead of Github

When refactoring and modifying code in this project while developing other projects, you may want your other project to point to the local source rather than the remote on Github. In your client project, you still need to keep the Gemfile pointing to the Github location but you can override your bundler setting like as follows:

`bundle config local.rad_common /Users/garyfoster/Documents/Projects/rad_common`

to undo this and revert to the remote github repository:

`bundle config --delete local.rad_common`
