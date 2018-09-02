module RadCommon
  module SecuredLinkHelper
    def link_authorized?(member_or_user, record)
      member_authorized?(member_or_user, record) || user_authorized?(member_or_user)
    end

    def record_name(record)
      "#{record.class.to_s.titleize} #{record.id}:"
    end

    private

    def member_authorized?(member, record)
      member.class.name == 'Member' && member.can_read?(record)
    end

    def user_authorized?(user)
      user.class.name == 'User' && user.super_admin?
    end
  end
end
