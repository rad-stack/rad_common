class HerokuCommands
  class << self
    def backup(app_name)
      check_production do
        FileUtils.mkdir_p dump_folder

        Bundler.with_unbundled_env do
          url_output = `heroku pg:backups public-url #{app_option(app_name)}`
          backup_url = "\"#{url_output.strip}\""

          write_log backup_url
          write_log 'Downloading last backup file:'
          write_log `curl -o #{backup_dump_file(app_name)} #{backup_url}`
        end
      end
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
      check_production do
        Bundler.with_unbundled_env do
          if backup_id.blank?
            write_log 'Running backup on Heroku...'
            `heroku pg:backups capture #{app_option(app_name)}`
          end

          url_output = if backup_id.present?
                         `heroku pg:backups public-url #{backup_id} #{app_option(app_name)}`
                       else
                         `heroku pg:backups public-url #{app_option(app_name)}`
                       end

          backup_url = "\"#{url_output.strip}\""

          write_log 'Downloading dump file:'
          write_log `curl -o #{clone_dump_file} #{backup_url}`
        end

        restore_from_backup(clone_dump_file)

        write_log 'Deleting temporary dump file'
        write_log `rm #{clone_dump_file}`

        write_log 'Migrating database'
        write_log `skip_on_db_migrate=1 rake db:migrate`

        write_log 'Changing passwords'
        change_user_passwords

        write_log 'Changing Active Storage service to local'
        ActiveStorage::Blob.update_all service_name: 'local'

        write_log 'Clearing certain production data'
        remove_user_avatars
        remove_accounting_keys
        User.update_all authy_enabled: false, authy_id: nil
      end
    end

    def reset_staging(app_name)
      Bundler.with_unbundled_env do
        unless heroku_rails_environment(app_name) == 'staging'
          write_log 'This is only available in the staging environment.'
          return
        end

        write_log `heroku pg:reset DATABASE_URL #{app_option(app_name)} --confirm #{app_name}`
        write_log `heroku run rails db:schema:load #{app_option(app_name)}`
        write_log `heroku run rails db:seed #{app_option(app_name)}`

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

      def check_production
        if Rails.env.production?
          write_log 'This is not available in the production environment.'
        else
          yield
        end
      end

      def change_user_passwords
        User.skip_callback :update, :after, :send_password_change_notification

        User.order(:id).find_each do |user|
          user.password = 'password'
          user.password_confirmation = 'password'

          unless user.save(validate: false)
            write_log "could not change password for user #{user.id}: #{user.errors.full_messages.join(' ')}"
          end
        end
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

        # TODO: pull this out of the generic gem and move to the Groundswell
        # TODO: project with some type of call back that can be project specific

        company.quickbooks_company_id = nil
        company.quickbooks_token = nil
        company.quickbooks_refresh_token = nil
        company.refresh_token_by = nil
        company.stripe_publishable_key = nil
        company.stripe_secret_key = nil

        company.save!(validate: false)
      end

      def write_log(message)
        puts message
      end
  end
end
