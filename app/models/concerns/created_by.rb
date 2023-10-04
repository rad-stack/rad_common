module CreatedBy
  extend ActiveSupport::Concern

  def created_by
    audits.where(action: 'create').first&.user
  end
end
