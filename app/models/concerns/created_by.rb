module CreatedBy
  extend ActiveSupport::Concern

  included do
    scope :for_created_by, lambda { |user_id|
      query = "#{table_name}.id IN (SELECT audits.auditable_id FROM audits " \
              "WHERE audits.auditable_type = ? AND audits.user_id = ? AND audits.action = 'create')"

      where(query, name, user_id).distinct
    }
  end

  def created_by
    audits.where(action: 'create').where.not(user_id: nil).first&.user
  end

  def modified_by
    audits.where.not(user_id: nil).first&.user
  end
end
