# RadCommon
This is a common set of features and tools tailored for a standard business web application.

## Features

### Common Email Template

### Views & Helpers

### User Maintenance
* RadbearUser concern
* UsersController
  * This can be overridden in each application but if all you need is to add additional permitted parameters, you can just add them to the additional_user_params array in the initializer
* User Views

### Date & Time Picker
#### Instructions
Add the following to your Javascript manifest file (`application.js`):
```
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap_datetimepicker/dates
```

Also, modify your `application.css`:
```
*= require bootstrap-datetimepicker
*= require bootstrap_datetimepicker/dates
```

#### Usage
##### To use the date picker:
- Using simple form: use the date field 
  - Example: `f.input :some_date, as: :date, html5: true`
- Using rails helpers: use `date_field` and `date_field_tag` with a 'date' class
  - Example: `date_field_tag "some_date", nil, class: 'date'`
  - Example: `date_field "user" "birthday", class: 'date'`

##### To use the time picker:
- Using simple form: use the time field with the html5 option turned on
  - Example: `f.input :some_time, as: :time, html5: true`
- Using rails helpers: use `time_field` and `time_field_tag` with a 'time' class
  - Example: `time_field_tag "some_time", nil, class: 'time'`
  - Example: `time_field "user" "favorite_time", class: 'time'`

##### To use the datetime picker:
- Using simple form: use the datetime_local field
  - Example: `f.input :some_datetime, as: :datetime_local`
- Using rails helpers: use `datetime_local_field` and `datetime_local_field_tag` with a 'datetime_local' class
  - Example: `datetime_local_field_tag "some_datetime", nil, class: 'datetime_local'`
  - Example: `datetime_local_field "user" "birth_datetime", class: 'datetime_local'`

##### Setting a default date/time
Set a `data-default` option:
- Example: `f.input :some_date, as: :date, html5: true, input_html: { 'data-default' => '2017-01-01' }`
- Example: `time_field_tag 'some_time', nil, { class: 'time', 'data-default' => '13:04'`

## Usage

### Server
To install rad_common, you must run the generator: 

`rails g rad_common:install`

This will then create the initializer in the /config/initializers directory with the default values set within the generator template as well as copy all the files to the project.

Emails are sent in the background so make sure you have a mailers queue running in sidekiq.

### Email Template
To use the common email template in your Rails project, just have your mailer subclass RadbearMailer.

## Generating tests
With the current version of rspec-rails we are not able to generate system ('feature') tests when we create the scaffold for an object. To achieve this you must run the generate command manually. Example: rails g rspec:system new_model

## Development

### Configuring
Add a .env file in `spec/dummy` containing the `AUTHY_API_KEY` that can be obtained by creating an authy app or from another developer

### Running
`bundle exec rails s`

`bundle exec rails c`

### Test Suite

To generate items related to the dummy app, first cd into the /spec/dummy directory, then you can run `rails generate` commands.

This project contains a "dummy" app to run test against, see /spec/dummy. To prepare the test database, run the following command:

`rails app:db:migrate`
`rails app:db:test:prepare`

To run the test suite, run the following command:

`bundle exec rspec --exclude-pattern 'spec/dummy/lib/**/*_spec.rb'`

### Point Projects to Local Source Instead of Github

When refactoring and modifying code in this project while developing other projects, you may want your other project to point to the local source rather than the remote on Github. In your client project, you still need to keep the Gemfile pointing to the Github location but you can override your bundler setting like as follows:

`bundle config local.rad_common /Users/garyfoster/Documents/Projects/rad_common`

to undo this and revert to the remote github repository:

`bundle config --delete local.rad_common`
