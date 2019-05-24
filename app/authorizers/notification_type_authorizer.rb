class NotificationTypeAuthorizer < ApplicationAuthorizer
  # class rules
  def self.creatable_by?(_user)
    false
  end

  def self.deletable_by?(_user)
    false
  end
end
