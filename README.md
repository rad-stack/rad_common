# RadCommon
This is a common set of features and tools tailored for a standard business web application.

## Server
To install rad_common, you must run the generator: 

`rails g rad_common:install`

This will then create the initializer in the /config/initializers directory with the default values set within the generator template as well as copy all the files to the project.

Emails are sent in the background so make sure you have a mailers queue running in sidekiq.

## Email Template
To use the common email template in your Rails project, just have your mailer subclass RadMailer.

## Heroku Database Utilities

Provides rake tasks which backup the current heroku postgresql database and copy the postgresql database to local to help troubleshoot

### Tasks

#### Heroku

Save a local backup from Heroku:
```
rails heroku:local_backup[ground-swell-staging]
```

Clone your database from Heroku:
```
rails heroku:clone_local[ground-swell-staging]
```

#### Local

Restore from a local backup:
```
rails local:restore_from_backup[latest.dump]
```

Dump your local database to an archive:
```
rails local:dump[your_data.dump]
```

## Generating tests
With the current version of rspec-rails we are not able to generate system ('feature') tests when we create the scaffold for an object. To achieve this you must run the generate command manually. Example: rails g rspec:system new_model

## Development

### Running
`bundle exec rails s`

`bundle exec rails c`

### Webpacker/Yarn updates
If changes are made to these items, you may need to compile both dev and test like the following:
```
cd spec/dummy

bundle exec yarn install
bundle exec rails webpacker:compile

RAILS_ENV=test bundle exec rails webpacker:compile
```

### Test Suite

To generate items related to the dummy app, first cd into the /spec/dummy directory, then you can run `rails generate` commands.

This project contains a "dummy" app to run test against, see /spec/dummy. To prepare the test database, run the following command:

`rails app:db:migrate`
`rails app:db:test:prepare`

To run the test suite, run the following command:

`bundle exec rspec`

### Point Projects to Local Source Instead of Github

When refactoring and modifying code in this project while developing other projects, you may want your other project to point to the local source rather than the remote on Github. In your client project, you can override the gem path like:

`gem 'rad_common', path: '/Users/garyfoster/Projects/rad_common'`

