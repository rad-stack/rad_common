class FirebaseDestroyJob < ApplicationJob
  queue_as :firebase

  def perform(app_id, firebase_reference)
    app = FirebaseApp.find(app_id)
    response = app.client.delete(firebase_reference)

    unless response.success?
      raise response.body
    end
  end
end
