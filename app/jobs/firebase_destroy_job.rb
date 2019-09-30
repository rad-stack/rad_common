class FirebaseDestroyJob < ApplicationJob
  queue_as :firebase

  def perform(firebase_reference)
    app = FirebaseApp.new
    response = RadicalRetry.perform_request { app.client.delete(firebase_reference) }

    return if response.success?

    raise response.raw_body
  end
end
