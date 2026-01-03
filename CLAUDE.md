# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

RadCommon is a Rails engine (gem) that provides common functionality for standard business web applications. It's designed to be integrated into Rails applications via a generator and includes authentication, authorization, auditing, notifications, and many other features.

## Key Architecture

### Rails Engine Structure

This is a **Rails Engine**, not a standalone Rails application. The main code is in standard Rails directories (`app/`, `lib/`), but it's mounted into host applications:

- `app/` - Contains controllers, models, views, services, policies, jobs, and helpers that are made available to host applications
- `lib/rad_common/` - Core engine code and configuration
- `spec/dummy/` - A minimal Rails application used for testing the engine

### Core Patterns

1. **Concerns-Based Architecture**: The gem provides functionality through mixins:
   - `RadController` - Main controller concern (Pundit authorization, Devise integration, impersonation, timezone handling)
   - `RadUser` - User model concern (associations, authentication via Devise)
   - `RadDeviseHigh`, `RadDeviseMedium`, `RadDeviseLow` - Tiered Devise configurations (high includes 2FA, lockable, expirable; medium/low have fewer security features)
   - `RadClient`, `RadCompany`, `RadSecurityRole` - Business domain concerns

2. **Configuration via RadConfig**: Centralized configuration service (`app/services/rad_config.rb`) that reads from Rails credentials. All configuration should go through RadConfig methods.

3. **Policy-Based Authorization**: Uses Pundit for authorization. All controllers enforce `verify_authorized` and `verify_policy_scoped`.

4. **Service Objects**: Business logic lives in service objects under `app/services/`:
   - Navigation services in `app/services/rad_nav/`
   - Search functionality in `app/services/rad_search/`
   - External integrations (Twilio, Smarty Streets, etc.)

5. **Background Jobs**: Sidekiq for async processing. Mailers use the `mailers` queue.

## Development Commands

### Setup
```bash
bundle install
rails app:db:migrate          # Migrate dummy app database
rails app:db:test:prepare     # Prepare test database
```

### Running Tests
```bash
bundle exec rspec                    # Run full test suite
bundle exec rspec spec/path/to/file  # Run single test file
rc_rspec                            # Run tests including shared specs
rc_parallel_rspec                   # Run tests in parallel
show_browser=true bundle exec rspec spec/system/  # Run system tests with visible browser
```

### Dummy Application
```bash
cd spec/dummy
bundle exec rails s              # Run dummy app server
bundle exec rails c              # Open dummy app console
```

Generate scaffolds and models in the dummy app by first cd'ing into `spec/dummy/`:
```bash
cd spec/dummy
rails generate scaffold ModelName field:type
rails generate rspec:system model_name  # Generate system tests manually
```

### Code Quality
```bash
bundle exec rubocop              # Run linter
bundle exec rubocop -a           # Auto-fix linting issues
bundle exec haml-lint            # Lint HAML views
```

### Asset Management (Dummy App)
```bash
cd spec/dummy
bundle exec yarn install
bundle exec rails webpacker:compile
RAILS_ENV=test bundle exec rails webpacker:compile
```

### Updating RadCommon in Client Projects
```bash
rc_update                           # Conservative update
rc_update --regenerate-lockfile     # Regenerate yarn.lock
rc_update --yarn-upgrade            # Upgrade yarn packages
```

## Installation in Host Applications

Install the generator in a Rails app:
```bash
rails g rad_common:install
```

This copies configuration files, initializers, and runs necessary migrations.

## Testing Strategy

### Test Organization
- `spec/models/` - Model unit tests
- `spec/services/` - Service object tests
- `spec/requests/` - Controller integration tests
- `spec/system/` - Feature/system tests using Capybara
- `spec/shared/` - Shared specs that run in both the engine and host apps
- `spec/factories/` - FactoryBot factories

### Test Configuration
- SimpleCov for coverage reporting
- Capybara with headless Chrome for system tests
- VCR for HTTP request mocking
- Custom helpers in `lib/rad_rspec/test_helpers.rb`
- Use `js: true` metadata for system tests requiring JavaScript
- Use `ignore_browser_errors: true` metadata to suppress browser console error checks

### Running Single Tests
Use standard RSpec syntax:
```bash
bundle exec rspec spec/models/user_spec.rb:45  # Run test at line 45
```

## Key Dependencies and Integration Points

### Authentication & Security
- **Devise** - User authentication (including invite, security extensions)
- **Pundit** - Authorization policies
- **Pretender** - User impersonation
- **Authtrail** - Login activity tracking
- **Audited** - Model auditing (uses `true_user` method)
- **Rack::Attack** - IP blocking

### Email & Notifications
- **SendGrid** - Email delivery (via SMTP)
- **Premailer** - Inline CSS in emails
- Emails sent via `RadMailer` base class
- Background email delivery via Sidekiq

### Frontend
- **Turbo Rails** - Hotwire Turbo for SPA-like interactions
- **Bootstrap 5** - UI framework
- **Simple Form** - Form builder
- **Kaminari** - Pagination
- **Tom Select** - Enhanced select dropdowns (referenced in test helpers)

### File Storage
- **Active Storage** - File uploads
- **AWS S3** - File storage backend
- Custom validations via `active_storage_validations`

### External Services
- **Twilio** - SMS and voice
- **Smarty Streets** - Address validation
- **Geocoder** - Geocoding
- **Sentry** - Error tracking

### PDF Generation
- **WickedPDF** with wkhtmltopdf-heroku

## Important Conventions

### Model Conventions
- Use concerns to add RadCommon functionality (e.g., `include RadUser` in User model)
- Auditing is automatic for models via Audited gem
- Use `true_user` for audit tracking (handles impersonation)

### Controller Conventions
- All controllers must `include RadController`
- Controllers require Pundit authorization
- Index actions must use `policy_scope`
- Use `redirect_to_path(record)` to respect redirect params

### Service Object Conventions
- Services are POROs in `app/services/`
- Navigation built via `RadNav` classes
- Search uses `RadSearch::Search` base class

### Configuration
- Never hardcode configuration - use `RadConfig` methods
- Configuration comes from Rails credentials
- Host applications override via `config/rad_common.yml`

### File Type Validation
- Valid file types defined as constants in `lib/rad_common.rb`:
  - `VALID_IMAGE_TYPES`
  - `VALID_ATTACHMENT_TYPES`
  - `VALID_AUDIO_TYPES`, `VALID_VIDEO_TYPES`, etc.

## Heroku Database Utilities

The gem provides rake tasks for Heroku database operations:

```bash
# Backup from Heroku
rails heroku:local_backup[app-name]

# Clone database from Heroku
rails heroku:clone_local[app-name]

# Restore from local backup
rails local:restore_from_backup[latest.dump]

# Dump local database
rails local:dump[filename.dump]
```

## Executable Binaries

The gem installs several executables (defined in gemspec):
- `rc_update` - Update RadCommon in client projects
- `rc_rspec` - Run tests including shared specs (runs both local specs and shared specs from engine)
- `rc_rspec_shared` - Run only shared specs
- `rc_parallel_rspec` - Run tests in parallel
- `reset_db` - Reset database
- `migrate_reset` - Reset and migrate
- `local_backup`, `clone_local` - Database utilities
- `creds` - Credentials helper
- `kill_ruby` - Kill Ruby processes
- `reset_staging` - Reset staging environment

## Local Development Linking

To test changes in a client project while developing RadCommon:

In the client project's Gemfile:
```ruby
gem 'rad_common', path: '/Users/garyfoster/Projects/rad_common'
```

Then run `bundle install` in the client project.

## Important Notes

- This is a **multi-client** system (users can belong to multiple clients via `user_clients`)
- **Timezone awareness** is built-in - all controllers run in user's timezone
- **Impersonation** is fully supported - use `true_user` vs `current_user`
- **Security roles** drive authorization - users have multiple roles via `user_security_roles`
- **System messages** and **notifications** are core features for user communication
- The gem uses **HAML** for views, not ERB
