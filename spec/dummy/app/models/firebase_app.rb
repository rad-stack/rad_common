class FirebaseApp
  attr_accessor :id, :name, :data_url, :secret_key, :categories, :push_url, :push_key

  def client
    Firebase::Client.new(data_url, secret_key)
  end

  def self.all
    # TODO: hardcoding this for now but should loop through the env vars properly
    # might be best to make it an actual model and not use env vars

    return [] if ENV['FIREBASE_DATA_URL'].blank?

    app_1 = FirebaseApp.new
    app_1.id = 1
    app_1.name = I18n.t(:app_name)
    app_1.data_url = ENV['FIREBASE_DATA_URL']
    app_1.secret_key = ENV['FIREBASE_SECRET_KEY']
    app_1.push_url = ENV['FIREBASE_PUSH_URL']
    app_1.push_key = ENV['FIREBASE_PUSH_KEY']
    app_1.categories = %w[registrations userActions]

    [app_1]
  end

  def self.enabled?
    FirebaseApp.all.any? && !Rails.env.test?
  end

  def self.find(id)
    FirebaseApp.all.each do |app|
      return app if app.id == id.to_i
    end

    raise "unknown firebase app: #{id}"
  end
end
