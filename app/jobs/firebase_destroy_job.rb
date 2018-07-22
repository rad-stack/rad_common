class FirebaseDestroyJob < ApplicationJob
  queue_as :firebase

  def perform(app_id, firebase_reference)
    app = FirebaseApp.find(app_id)
    response = RadicalRetry.perform_request { app.client.delete(firebase_reference) }

    return if response.success?
    raise response.raw_body
  end
end
