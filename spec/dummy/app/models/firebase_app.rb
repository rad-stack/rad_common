class FirebaseApp
  attr_accessor :name, :data_url, :secret_key, :categories, :push_url, :push_key

  def initialize
    self.name = I18n.t(:app_name)
    self.data_url = ENV['FIREBASE_DATA_URL']
    self.secret_key = ENV['FIREBASE_SECRET_KEY']
    self.push_url = ENV['FIREBASE_PUSH_URL']
    self.push_key = ENV['FIREBASE_PUSH_KEY']
    self.categories = %w[registrations userActions]
  end

  def client
    Firebase::Client.new(data_url, secret_key)
  end

  def self.enabled?
    ENV['FIREBASE_DATA_URL'].present? && !Rails.env.test?
  end
end
