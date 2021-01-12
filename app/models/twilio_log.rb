class TwilioLog < ApplicationRecord
  belongs_to :user, optional: true
end
