class RadAuditSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user
    @params = params

    super(query: query_def,
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  def single_record?
    params.dig(:search, :single_record).present?
  end

  def single_record
    return unless single_record?

    params[:search][:single_record].split(':').first.constantize.find(params[:search][:single_record].split(':').last)
  end

  private

    def query_def
      if single_record?
        RadAudit.where(auditable: single_record).or(RadAudit.where(associated: single_record))
      else
        RadAudit
      end
    end

    def filters_def
      items = [{ name: 'single_record', type: RadCommon::HiddenFilter },
               { start_input_label: 'Start Date',
                 end_input_label: 'End Date',
                 column: :created_at,
                 type: RadCommon::DateFilter }]

      unless single_record?
        items += [{ input_label: 'Record Type',
                    column: :auditable_type,
                    options: RadCommon::AppInfo.new.audited_models },
                  { column: :auditable_id,
                    type: RadCommon::EqualsFilter,
                    data_type: :integer,
                    input_label: 'Record ID' }]
      end

      items + [{ input_label: 'User', column: :user_id, options: user_array, include_nil_option: true },
               { input_label: 'Action',
                 column: :action,
                 options: %w[create update destroy] },
               { column: :remote_address, type: RadCommon::LikeFilter },
               { column: 'audited_changes::TEXT', type: RadCommon::LikeFilter, name: :audited_changes }]
    end

    def sort_columns_def
      [{ label: 'Date', column: 'created_at', direction: 'desc', default: true },
       { label: 'Record Type', column: 'auditable_type' },
       { label: 'Record ID', column: 'auditable_id' },
       { label: 'User' },
       { label: 'Action' },
       { label: 'Remote Address', column: 'remote_address' },
       { label: 'Audit ID', column: 'audits.id' },
       { label: 'Changes' }]
    end

    def user_array
      Pundit.policy_scope!(current_user, User).sorted.pluck(Arel.sql("first_name || ' ' || last_name"), :id)
    end
end
