class FirebaseSyncJob < ApplicationJob
  queue_as :firebase

  def perform(model_name, record_id)
    klass = Object.const_get model_name
    record = klass.find_by_id(record_id)

    if record
      record.firebase_sync
    else
      puts "firebase sync: could not find #{model_name} with id #{record_id}"
    end
  end
end
