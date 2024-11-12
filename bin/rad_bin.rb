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

  def self.get_heroku_app_name
    heroku_app_name = Dir.pwd.split('/').last.gsub('_', '-')

    unless heroku_app_exists?(heroku_app_name)
      puts "Could not ind accessible Heroku app: #{heroku_app_name}."
      print 'Please enter a valid Heroku app name: '
      heroku_app_name = gets.chomp.strip
    end

    heroku_app_name
  end
end
