class HerokuCommands
  class << self
    def app_option(app_name = '')
      app_name.blank? ? '' : "--app #{app_name}"
    end

    def backup_dump_file(app_name = '')
      if app_name.blank?
        "#{dump_folder}/#{Date.current}.backup"
      else
        "#{dump_folder}/#{app_name}_#{Date.current}.backup"
      end
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

    def backup(app_name = '')
      check_production do
        FileUtils.mkdir_p dump_folder

        Bundler.with_unbundled_env do
          url_output = `heroku pg:backups public-url #{app_option(app_name)}`
          backup_url = '"' + url_output.strip + '"'

          puts backup_url
          puts 'Downloading last backup file:'
          puts `curl -o #{backup_dump_file} #{backup_url}`
        end
      end
    end

    def restore_from_backup(file_name)
      puts 'Dropping existing database schema'
      puts `psql -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public" -h #{local_host} -U #{local_user} -d #{dbname}`
      puts 'Restoring dump file to local'
      puts `pg_restore --verbose --clean --no-acl --no-owner -h #{local_host} -U #{local_user} -d #{dbname} #{file_name}`
    end

    def dump(file_name = '')
      dump_file_name = file_name.presence || 'your_data.dump'
      puts 'Dumping your local database'
      puts `pg_dump --verbose --clean -Fc -h #{local_host} -U #{local_user} -f #{dump_file_name} -d #{dbname}`
    end

    def clone(app_name = '', specific_company_id: nil, keep_dump_file: nil)
      check_production do
        puts 'Running backup on Heroku...'
        Bundler.with_unbundled_env do
          capture_output = `heroku pg:backups capture #{app_option(app_name)}`
          url_output     = `heroku pg:backups public-url #{app_option(app_name)}`
          backup_url     = '"' + url_output.strip + '"'

          puts 'Downloading dump file:'
          puts `curl -o #{clone_dump_file} #{backup_url}`
        end

        restore_from_backup(clone_dump_file)

        puts 'Deleting temporary dump file'
        puts `rm #{clone_dump_file}`

        puts 'Migrating database'
        puts `skip_on_db_migrate=1 rake db:migrate`

        puts 'Changing passwords'
        change_user_passwords

        puts 'Clearing certain production data'
        remove_user_avatars
        remove_accounting_keys
        User.update_all authy_enabled: false

        remove_unspecified_companies(specific_company_id) if specific_company_id.present?

        dump if keep_dump_file.present?
      end
    end

    private

      def check_production
        if !Rails.env.production?
          yield
        else
          puts 'This is not available in the production environment.'
        end
      end

      def change_user_passwords
        User.order(:id).find_each do |user|
          user.password = 'password'
          user.password_confirmation = 'password'

          unless user.save(validate: false)
            puts "could not change password for user #{user.id}: #{user.errors.full_messages.join(' ')}"
          end
        end
      end

      def remove_user_avatars
        if User.new.respond_to?(:avatar)
          User.joins(:avatar_attachment).order(:id).each do |user|
            user.avatar.purge_later
          end
        end
      end

      def remove_accounting_keys
        Company.find_each do |company|
          if company.respond_to?(:quickbooks_access_token)
            # TODO: pull this out of the generic gem and move to the Groundswell project with some type of call back that can be project specific
            # same with avatars & logos above, those should only run for RBMT projects

            company.quickbooks_company_id = nil
            company.quickbooks_token = nil
            company.quickbooks_refresh_token = nil
            company.refresh_token_by = nil
            company.stripe_publishable_key = nil
            company.stripe_secret_key = nil

            company.save!(validate: false)
          end
        end
      end

      def remove_unspecified_companies(specific_company_id)
        # TODO: this should only be applicable for RBMT projects

        puts 'Removing other company info'
        Company.where.not(id: specific_company_id).each do |company|
          puts "Destroying company: #{company.name}"
          company.destroy_company!
        end
      end
  end
end
