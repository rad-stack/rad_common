require 'platform-api'

class HerokuCommands
  IGNORED_HEROKU_ERRORS = ['free Heroku Dynos will'].freeze

  class << self
    # This initializes the client, need to add api key
    def heroku_client
      @heroku_client ||= PlatformAPI.connect_oauth(ENV['api_key'])
    end

    def backup(app_name)
      check_production!

      check_valid_app(app_name)
      FileUtils.mkdir_p dump_folder

      # This uses the api for backup
      backup = heroku_client.backup.capture.create(app_name)
      backup_url = backup['public-url']

      write_log backup_url
      write_log 'Downloading last backup file:'
      write_log `curl -o #{backup_dump_file(app_name)} #{backup_url}`
    end

    def restore_from_backup(file_name)
      write_log 'Dropping existing database schema'
      write_log `psql -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public" -h #{local_host} -U #{local_user} -d #{dbname}`
      write_log 'Restoring dump file to local'
      write_log `pg_restore --verbose --clean --no-acl --no-owner -h #{local_host} -U #{local_user} -d #{dbname} #{file_name}`
    end

    def dump(file_name = '')
      dump_file_name = file_name.presence || 'your_data.dump'
      write_log 'Dumping your local database'
      write_log `pg_dump --verbose --clean -Fc -h #{local_host} -U #{local_user} -f #{dump_file_name} -d #{dbname}`
    end

    def clone(app_name, backup_id)
      check_production!

      check_valid_app(app_name)

      # This captures a backup if blank
      backup_id ||= heroku_client.backup.capture.create(app_name)['id']

      # This fetches the backup info
      backup_info = heroku_client.backup.info(app_name, backup_id)
      backup_url = backup_info['public-url']
      write_log backup_url

      write_log 'Downloading dump file:'
      write_log `curl -o #{clone_dump_file} #{backup_url}`

      restore_from_backup(clone_dump_file)

      write_log 'Deleting temporary dump file'
      write_log `rm #{clone_dump_file}`

      write_log 'Migrating database'
      write_log `skip_on_db_migrate=1 rake db:migrate`

      write_log 'Changing passwords'
      new_password = User.new.send(:password_digest, 'password')
      User.update_all(encrypted_password: new_password)

      write_log 'Changing Active Storage service to local'
      ActiveStorage::Blob.update_all service_name: 'local'

      write_log 'Clearing certain production data'
      remove_user_avatars
      remove_accounting_keys
      User.update_all twilio_verify_enabled: false
      nil
    end

    def reset_staging(app_name)
      check_valid_app(app_name)
      unless heroku_rails_environment(app_name) == 'staging'
        write_log 'This is only available in the staging environment.'
        return
      end

      # This resets the database
      heroku_client.pg_reset.create(app_name)

      # This restarts the app
      heroku_client.dyno.restart_all(app_name)

      write_log 'Done.'
    end

    def copy_production_data(production_app_name, staging_app_name)
      check_valid_app(production_app_name)
      check_valid_app(staging_app_name)
      unless heroku_rails_environment(staging_app_name) == 'staging'
        write_log 'This is only available in the staging environment.'
        return
      end

      # This copies the production database to staging
      heroku_client.pg_copy.create(production_app_name, staging_app_name)

      # This restarts the staging app
      heroku_client.dyno.restart_all(staging_app_name)

      write_log 'Done.'
    end

    private



      def app_option(app_name)
        "--app #{app_name}"
      end

      # This gets the rails environment from Heroku
      def heroku_rails_environment(app_name)
        heroku_client.config_var.info(app_name)['RAILS_ENV']
      end

      def backup_dump_file(app_name)
        "#{dump_folder}/#{app_name}_#{Date.current}.backup"
      end

      def clone_dump_file
        'latest.dump'
      end

      def dump_folder
        "#{Rails.root}/heroku_backups"
      end

      def local_host
        'localhost'
      end

      def local_user
        `whoami`.strip!
      end

      def dbname
        YAML.load_file('config/database.yml')['development']['database']
      end

      def check_production!
        raise 'This is not available in the production environment.' if Rails.env.production?
      end

      def remove_user_avatars
        return unless User.new.respond_to?(:avatar)

        User.joins(:avatar_attachment).order(:id).each do |user|
          user.avatar.purge_later
        end
      end

      def remove_accounting_keys
        company = Company.main
        return unless company.respond_to?(:quickbooks_access_token)

        company.quickbooks_company_id = nil
        company.quickbooks_token = nil
        company.quickbooks_refresh_token = nil
        company.refresh_token_by = nil

        company.save!(validate: false)
      end

      def write_log(message)
        puts message
      end

      # This checks if an app is valid
      def check_valid_app(app_name)
        begin
          heroku_client.app.info(app_name)
        rescue StandardError => e
          raise "Invalid app: #{e.message}"
        end
      end

      def valid_error?(error)
        return false if error.blank?

        IGNORED_HEROKU_ERRORS.select { |ignored_error| error.include?(ignored_error) }.blank?
      end
  end
end
