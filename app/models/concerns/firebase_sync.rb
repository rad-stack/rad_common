module FirebaseSync
  extend ActiveSupport::Concern

  included do
    after_commit :firebase_sync_job, on: [:create, :update]
    after_commit :firebase_destroy_job, on: [:destroy]
  end

  def firebase_reference
    "#{self.class.table_name.camelize(:lower)}/id#{self.id}"
  end

  def firebase_client
    Firebase::Client.new(ENV["FIREBASE_DATA_URL"], ENV["FIREBASE_SECRET_KEY"])
  end

  def firebase_datetime(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def firebase_date(date)
    date.strftime("%Y-%m-%d")
  end

  def get_firebase_data(path)
    response = firebase_client.get(path)

    unless response.success?
      raise "#{response.body}"
    end

    response.body
  end

  private

    def firebase_sync_job
      FirebaseSyncJob.perform_later(self.class.name, self.id) unless Rails.env.test? || self.firebase_reference.nil?
    end

    def firebase_destroy_job
      FirebaseDestroyJob.perform_later(self.firebase_reference) unless Rails.env.test? || self.firebase_reference.nil?
    end

end
