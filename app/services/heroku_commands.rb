class HerokuCommands
  IGNORED_HEROKU_ERRORS = ['free Heroku Dynos will'].freeze

  class << self
    def backup(app_name)
      check_production!

      check_valid_app(app_name)
      FileUtils.mkdir_p dump_folder

      Bundler.with_unbundled_env do
        url_output = `heroku pg:backups:url #{app_option(app_name)}`
        backup_url = "\"#{url_output.strip}\""

        write_log backup_url
        write_log 'Downloading last backup file:'
        write_log `curl -o #{backup_dump_file(app_name)} #{backup_url}`
      end
    end

    def restore_from_backup(file_name)
      write_log 'Dropping existing database schema'
      write_log `psql -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public" -h #{local_host} -U #{local_user} -d #{dbname}`
      write_log 'Restoring dump file to local'
      write_log `pg_restore --verbose --clean --no-acl --no-owner -h #{local_host} -U #{local_user} -d #{dbname} #{file_name}`

      write_log 'Migrating database'
      write_log `skip_on_db_migrate=1 rake db:migrate`

      write_log 'Changing passwords'
      new_password = User.new.send(:password_digest, 'password')
      User.update_all(encrypted_password: new_password)

      write_log 'Changing Active Storage service to local'
      ActiveStorage::Blob.update_all service_name: 'local'

      write_log 'Clearing certain production data'
      remove_user_avatars
      remove_encrypted_secrets
      User.update_all twilio_verify_enabled: false
      nil
    end

    def dump(file_name = '')
      dump_file_name = file_name.presence || 'your_data.dump'
      write_log 'Dumping your local database'
      write_log `pg_dump --verbose --clean -Fc -h #{local_host} -U #{local_user} -f #{dump_file_name} -d #{dbname}`
    end

    def clone(app_name, backup_id)
      check_production!

      Bundler.with_unbundled_env do
        check_valid_app(app_name)
        if backup_id.blank?
          write_log 'Running backup on Heroku...'
          `heroku pg:backups:capture #{app_option(app_name)}`
        end

        url_output = if backup_id.present?
                       `heroku pg:backups:url #{backup_id} #{app_option(app_name)}`
                     else
                       `heroku pg:backups:url #{app_option(app_name)}`
                     end

        backup_url = "\"#{url_output.strip}\""

        write_log 'Downloading dump file:'
        write_log `curl -o #{clone_dump_file} #{backup_url}`
      end

      restore_from_backup(clone_dump_file)

      write_log 'Deleting temporary dump file'
      write_log `rm #{clone_dump_file}`

      nil
    end

    def reset_staging(app_name)
      Bundler.with_unbundled_env do
        check_valid_app(app_name)
        unless heroku_rails_environment(app_name) == 'staging'
          write_log 'This is only available in the staging environment.'
          return
        end

        write_log `heroku ps:scale web=0 worker=0 #{app_option(app_name)}`
        write_log `heroku run rails runner "'Sidekiq.redis(&:flushdb)'" #{app_option(app_name)}`
        write_log `heroku pg:reset DATABASE_URL #{app_option(app_name)} --confirm #{app_name}`
        write_log `heroku run rails db:schema:load #{app_option(app_name)}`
        write_log `heroku run rails db:seed #{app_option(app_name)}`
        write_log `heroku ps:scale web=1 worker=1 #{app_option(app_name)}`

        write_log 'Done.'
      end
    end

    def copy_production_data(production_app_name, staging_app_name)
      Bundler.with_unbundled_env do
        check_valid_app(production_app_name)
        check_valid_app(staging_app_name)
        unless heroku_rails_environment(staging_app_name) == 'staging'
          write_log 'This is only available in the staging environment.'
          return
        end

        write_log `heroku pg:copy #{production_app_name}::DATABASE_URL DATABASE_URL --app #{staging_app_name}`
        write_log `heroku restart --app #{staging_app_name}`
        write_log `heroku run rails db:migrate --app #{staging_app_name}`

        write_log 'Done.'
      end
    end

    private

      def app_option(app_name)
        "--app #{app_name}"
      end

      def heroku_rails_environment(app_name)
        `heroku config:get RAILS_ENV #{app_option(app_name)}`.strip
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

      def remove_encrypted_secrets
        [Company, User].each do |klass|
          klass.encrypted_attributes&.each do |attribute_name|
            klass.where.not(attribute_name => nil).update_all "#{attribute_name}": nil
          end
        end
      end

      def write_log(message)
        puts message
      end

      def check_valid_app(app_name)
        _output, error = Open3.capture3("heroku apps:info #{app_option(app_name)}")

        raise error if valid_error?(error)
      end

      def valid_error?(error)
        return false if error.blank?

        IGNORED_HEROKU_ERRORS.select { |ignored_error| error.include?(ignored_error) }.blank?
      end
  end
end
