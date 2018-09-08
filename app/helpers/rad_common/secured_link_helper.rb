module RadCommon
  module SecuredLinkHelper
    def link_authorized?(user, record)
      user_authorized?(user)
    end

    def record_name(record)
      "#{record.class.to_s.titleize} #{record.id}:"
    end

    private

      def user_authorized?(user)
        user.class.name == 'User' && user.super_admin?
      end
  end
end
