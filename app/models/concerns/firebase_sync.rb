module FirebaseSync
  extend ActiveSupport::Concern

  included do
    after_commit :firebase_sync_job, on: [:create, :update]
    after_commit :firebase_destroy_job, on: [:destroy]
  end

  def firebase_reference
    "#{self.class.table_name.camelize(:lower)}/id#{id}"
  end

  def firebase_datetime(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def firebase_date(date)
    date.strftime("%Y-%m-%d")
  end

  def get_firebase_data(app, path)
    response = app.client.get(path)

    unless response.success?
      raise response.body
    end

    response.body
  end

  private

  def firebase_sync_job
    firebase_sync_apps.each do |app_id|
      FirebaseSyncJob.perform_later(app_id, self.class.name, id) unless Rails.env.test? || firebase_reference.nil?
    end
  end

  def firebase_destroy_job
    firebase_sync_apps.each do |app_id|
      FirebaseDestroyJob.perform_later(app_id, firebase_reference) unless Rails.env.test? || firebase_reference.nil?
    end
  end

end
