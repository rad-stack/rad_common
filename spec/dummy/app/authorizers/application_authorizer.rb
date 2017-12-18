# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  def self.creatable_by?(user)
    user.admin
  end

  def self.readable_by?(user)
    user.admin
  end

  def self.updatable_by?(user)
    user.admin
  end

  def self.deletable_by?(user)
    user.admin
  end

  def self.global_validatable_by?(user)
    user.admin
  end

  def self.auditable_by?(user)
    user.admin
  end

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(adjective, user)
    # 'Whitelist' strategy for security: anything not explicitly allowed is
    # considered forbidden.
    false
  end

end
