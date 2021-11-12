require 'csv'

class UsersCSV
  def self.generate(users)
    CSV.generate do |csv|
      csv << headers
      users.each { |user| csv << user_attributes(user) }
    end
  end

  def self.headers
    ['Name', 'Email', 'Signed In', 'Created', 'Status', 'Roles', 'Client User?']
  end

  class << self
    private

      def user_attributes(user)
        user_type = user.external? ? 'Yes' : 'No'
        [
          user.to_s,
          user.email,
          ApplicationController.helpers.format_datetime(user.current_sign_in_at),
          ApplicationController.helpers.format_date(user.created_at),
          user.user_status.to_s,
          user.security_roles.map(&:name).join('/'),
          user_type
        ]
      end
  end
end
