class SecurityRole < ApplicationRecord
  include RadSecurityRole
  scope :authorized, ->(_) {}
end
