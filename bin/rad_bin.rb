require 'English'
require 'fileutils'

module RadBin
  def self.system!(*args)
    system(*args) || abort("\n== Command #{args.join(' ')} failed ==")
  end

  def self.rad_common_not_permitted!
    return unless Dir.pwd.include?('rad_common')

    puts '== rad_common is not applicable for this operation =='
    exit
  end

  def self.heroku_app_exists?(app_name)
    `heroku apps:info --app #{app_name}`
    $CHILD_STATUS.success?
  end

  def self.get_heroku_app_name(environment)
    heroku_apps = parse_heroku_apps

    filtered_apps = case environment
                    when :all
                      heroku_apps
                    when :production
                      heroku_apps.reject { |item| item.include? 'staging' }
                    when :staging
                      heroku_apps.select { |item| item.include? 'staging' }
                    end

    heroku_app_name = select_heroku_app(filtered_apps)
    return heroku_app_name if heroku_app_exists?(heroku_app_name)

    puts "Could not find accessible Heroku app: #{heroku_app_name}."
    exit 1
  end

  def self.parse_heroku_apps
    git_remote_output = `git remote -v`
    heroku_lines = git_remote_output.lines.select { |item| item.include? 'heroku.com' }

    heroku_lines.map { |line|
      line.split('heroku.com/').last.split('.git').first
    }.uniq.sort
  end

  def self.select_heroku_app(heroku_app_names)
    return heroku_app_names.first if heroku_app_names.length == 1

    puts "\nPlease select a Heroku app from the following options:"

    heroku_app_names.each_with_index do |app_name, index|
      puts "#{index + 1}. #{app_name}"
    end

    choice = $stdin.gets.chomp.to_i
    return heroku_app_names[choice - 1] if choice.between?(1, heroku_app_names.size)

    puts "\nInvalid choice. Exiting..."
    exit 1
  end

  def self.select_backup_id(heroku_app_name)
    backup_list = parse_backup_list(heroku_app_name)

    puts "\nPlease select a backup id from the following options:"

    backup_list.each_with_index do |backup, index|
      puts "#{index + 1}. #{backup[:id]} created at (#{backup[:created_at]})"
    end

    choice = $stdin.gets.chomp.to_i
    return backup_list[choice - 1][:id] if choice.between?(1, backup_list.size)

    puts "\nInvalid choice. Exiting..."
    exit 1
  end

  def self.parse_backup_list(heroku_app_name)
    backups = `heroku pg:backups --app #{heroku_app_name}`
    # Extract the "=== Backups" section
    backups = backups.split('=== Backups').last.split('===').first
    lines = backups.strip.split("\n")
    data_rows = lines[4..] # Skip header and separator line

    data_rows.map do |line|
      values = line.strip.split
      { id: values[0], created_at: values[1] }
    end
  end
end
