# RadCommon

This application uses the RadCommon Rails engine, which provides common functionality for standard business web applications including authentication, authorization, auditing, notifications, and many other features.

## Core Patterns

1. **Concerns-Based Architecture**: RadCommon provides functionality through mixins:
    - `RadController` - Main controller concern (Pundit authorization, Devise integration, impersonation, timezone handling)
    - `RadUser` - User model concern (associations, authentication via Devise)
    - `RadDeviseHigh`, `RadDeviseMedium`, `RadDeviseLow` - Tiered Devise configurations (high includes 2FA, lockable, expirable; medium/low have fewer security features)
    - `RadClient`, `RadCompany`, `RadSecurityRole` - Business domain concerns

2. **Configuration via RadConfig**: Centralized configuration service (`rad_config.rb`) that reads from Rails credentials. All configuration should go through RadConfig methods. Host applications override via `config/rad_common.yml`.

3. **Policy-Based Authorization**: Uses Pundit for authorization. All controllers enforce `verify_authorized` and `verify_policy_scoped`.

4. **Service Objects**: Business logic lives in service objects under `app/services/`:
    - Navigation services in `app/services/rad_nav/`
    - Search functionality in `app/services/rad_search/`
    - External integrations (Twilio, Smarty Streets, etc.)

5. **Background Jobs**: Sidekiq for async processing. Mailers use the `mailers` queue.

## Development Commands

### Running Tests
```bash
bundle exec rspec                    # Run full test suite
bundle exec rspec spec/path/to/file  # Run single test file
bundle exec rspec spec/models/user_spec.rb:45  # Run test at line 45
rc_rspec                            # Run tests including shared specs from engine
rc_parallel_rspec                   # Run tests in parallel
show_browser=true bundle exec rspec spec/system/  # Run system tests with visible browser
```

### Code Quality
```bash
bundle exec rubocop              # Run linter
bundle exec rubocop -a           # Auto-fix linting issues
bundle exec haml-lint            # Lint HAML views
```

### Updating RadCommon
```bash
rc_update                           # Conservative update
rc_update --regenerate-lockfile     # Regenerate yarn.lock
rc_update --yarn-upgrade            # Upgrade yarn packages
```

### Scaffolding
```bash
rails generate scaffold ModelName field:type
rails generate rspec:system model_name  # Generate system tests manually
```

## Testing Strategy

### Test Organization
- `spec/models/` - Model unit tests
- `spec/services/` - Service object tests
- `spec/requests/` - Controller integration tests
- `spec/system/` - Feature/system tests using Capybara
- `spec/factories/` - FactoryBot factories

### Test Configuration
- SimpleCov for coverage reporting
- Capybara with headless Chrome for system tests
- VCR for HTTP request mocking
- Use `js: true` metadata for system tests requiring JavaScript
- Use `ignore_browser_errors: true` metadata to suppress browser console error checks

## Key Dependencies

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
- **Tom Select** - Enhanced select dropdowns

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

```bash
rails heroku:local_backup[app-name]          # Backup from Heroku
rails heroku:clone_local[app-name]           # Clone database from Heroku
rails local:restore_from_backup[latest.dump] # Restore from local backup
rails local:dump[filename.dump]              # Dump local database
```

## Executable Binaries

- `rc_update` - Update RadCommon in client projects
- `rc_rspec` - Run tests including shared specs from engine
- `rc_rspec_shared` - Run only shared specs
- `rc_parallel_rspec` - Run tests in parallel
- `reset_db` - Reset database
- `migrate_reset` - Reset and migrate
- `local_backup`, `clone_local` - Database utilities
- `creds` - Credentials helper
- `kill_ruby` - Kill Ruby processes
- `reset_staging` - Reset staging environment

## Important Notes

- This is a **multi-client** system (users can belong to multiple clients via `user_clients`)
- **Timezone awareness** is built-in - all controllers run in user's timezone
- **Impersonation** is fully supported - use `true_user` vs `current_user`
- **Security roles** drive authorization - users have multiple roles via `user_security_roles`
- **System messages** and **notifications** are core features for user communication
- The gem uses **HAML** for views, not ERB
