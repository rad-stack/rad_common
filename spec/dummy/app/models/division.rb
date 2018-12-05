class Division < ApplicationRecord
  include Authority::Abilities
  include FirebaseSync
  include FirebaseAction

  belongs_to :owner, class_name: 'User'

  alias_attribute :to_s, :name
  enum division_status: %i[status_pending status_active status_inactive]

  scope :authorized, ->(_) {}

  audited

  def firebase_sync(app)
    data = { name: name }

    response = RadicalRetry.perform_request { app.client.update(firebase_reference, data) }
    return if response.success?

    raise RadicallyIntermittentException, response.raw_body
  end
end
