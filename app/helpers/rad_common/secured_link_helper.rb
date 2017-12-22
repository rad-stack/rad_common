module RadCommon
  module SecuredLinkHelper
    def link_authorized?(member_or_user, record)
      member_authorized?(member_or_user, record) || user_authorized?(member_or_user)
    end

    def record_url(record)
      if record.respond_to?(:company)
        company = record.company
      end

      url = url_for(record)

      if record.respond_to?(:company)
        url.sub('app', company.company_code)
      else
        url
      end
    end

    def record_name(record)
      "#{record.class.to_s.titleize} #{record.id}:"
    end

    private

    def member_authorized?(member, record)
      member.is_a?(Member) && member.can_read?(record)
    end

    def user_authorized?(user)
      user.is_a?(User) && user.super_admin?
    end
  end
end
