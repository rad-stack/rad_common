module FirebaseSync
  extend ActiveSupport::Concern

  included do
    after_commit :firebase_sync_job, on: %i[create update]
    after_commit :firebase_destroy_job, on: [:destroy]
  end

  def firebase_reference
    "#{self.class.table_name.camelize(:lower)}/id#{id}"
  end

  def firebase_datetime(datetime)
    datetime&.strftime('%Y-%m-%d %H:%M:%S')
  end

  def firebase_date(date)
    date&.strftime('%Y-%m-%d') if date
  end

  def get_firebase_data(app, path)
    response = RadicalRetry.perform_request { app.client.get(path) }
    raise RadicallyIntermittentException, response.raw_body unless response.success?

    response.body
  end

  private

    def firebase_sync_job
      return unless FirebaseApp.enabled?

      FirebaseSyncJob.perform_later(self.class.name, id) unless firebase_reference.nil?
    end

    def firebase_destroy_job
      return unless FirebaseApp.enabled?

      FirebaseDestroyJob.perform_later(firebase_reference) unless firebase_reference.nil?
    end
end
