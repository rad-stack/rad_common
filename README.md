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

## swo — querying production logs

`swo` is a standalone CLI (installed as a gem executable) for querying production logs from
SolarWinds Observability (SWO, the successor to Papertrail). It is pure Ruby stdlib — no Rails
boot — so it is fast and works from any RadStack app directory.

### Setup

`swo` reads an SWO org-wide "API Access" token from `~/.config/swo/token`. A single org token
reads **all** apps' logs:

```
mkdir -p ~/.config/swo && pbpaste > ~/.config/swo/token && chmod 600 ~/.config/swo/token
swo auth        # verify the token works
```

### Usage

```
swo search <text> [opts]   # print matching log lines (newest first)
swo volume <text> [opts]   # bar chart of match counts per day/hour
swo tail   <text> [opts]   # stream new matching lines
```

Apps are distinguished by their `host`, which equals the **Heroku app name**. By default `swo`
auto-detects the project's single production Heroku app from its git remotes (the same source
`clone_local` / `local_backup` use). If a project has zero or more than one production app, `swo`
aborts and lists them; choose one with `--host NAME`, or query every app with `--all`.

```
swo search 'AutoRefillJob' --since 24h
swo search '"completed payment"' -p worker
swo volume 'patient_contact_histories' --since 7d -b day
swo search 'error' --host mayoshift -p web
```

Options: `--host NAME` / `--all`, `-p/--program` (web | worker | router | web.1 …),
`-s/--since` (e.g. `30m`, `6h`, `7d`), `-n/--limit`, `-b/--bucket` (day | hour), `--json`.

### Gotchas

- **Use `host:<name>`, not `hostname:<name>`** — the latter silently returns zero rows. `swo`
  builds `host:` for you; only relevant if you hand-write a raw `filter`.
- **`filter` matches log TEXT** (URL paths, `class=XJob`, `program:web`), not Ruby class names.
- **~9 days of retention** — older `--since` windows return empty (`swo` warns).
- **No server-side aggregation** — SWO's API only returns individual lines, so `volume` counts
  client-side by paging. Over wide windows it warns when it hits its page cap and the totals
  become a lower bound; narrow `--since` or add filter text for an exact count.

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
