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
    $?.success?
  end

  def self.get_heroku_app_name(environment)
    heroku_apps = parse_heroku_apps

    filtered_apps = case environment
                    when :all
                      heroku_apps
                    when :production
                      heroku_apps.select { |item| !item.include? 'staging' }
                    when :staging
                      heroku_apps.select { |item| item.include? 'staging' }
                    end

    heroku_app_name = if filtered_apps.length == 1
                        filtered_apps.first
                      else
                        puts "\nPlease select a Heroku app from the following options:"

                        filtered_apps.each_with_index do |app_name, index|
                          puts "#{index + 1}. #{app_name}"
                        end

                        choice = STDIN.gets.chomp.to_i

                        if choice.between?(1, filtered_apps.size)
                          filtered_apps[choice - 1]
                        else
                          nil
                        end
                      end

    if heroku_app_name.nil?
      puts "\nInvalid choice. Exiting..."
      exit 1
    elsif heroku_app_exists?(heroku_app_name)
      heroku_app_name
    else
      puts "Could not find accessible Heroku app: #{heroku_app_name}."
      exit 1
    end
  end

  def self.parse_heroku_apps
    git_remote_output = `git remote -v`
    heroku_lines = git_remote_output.lines.select { |item| item.include? 'heroku.com' }

    heroku_lines.map { |line|
      line.split('heroku.com/').last.split('.git').first
    }.uniq.sort
  end
end
