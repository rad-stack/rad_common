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

    prompt = TTY::Prompt.new
    prompt.select('Please select a Heroku app from the following options:', heroku_app_names)
  end

  def self.select_backup_id(heroku_app_name)
    sorted_backup_list = parse_backup_list(heroku_app_name)

    backup_hash = sorted_backup_list.to_h { |b| ["#{b[:id]} created at (#{b[:created_at]})", b[:id]] }
    choices = sorted_backup_list.map { |b| "#{b[:id]} created at (#{b[:created_at]})" }
    prompt = TTY::Prompt.new
    choice = prompt.select('Please select a backup id from the following options:', choices)
    backup_hash[choice]
  end

  def self.parse_backup_list(heroku_app_name)
    backups = `heroku pg:backups --app #{heroku_app_name}`
    backups = backups.split('=== Backups').last.split('===').first
    lines = backups.strip.split("\n")
    data_rows = lines[4..]

    data_rows.map do |line|
      values = line.strip.split
      { id: values[0], created_at: values[1] }
    end
  end
end
