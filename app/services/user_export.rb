class UserExport < Exporter
  private

    def headers
      ['Name', 'Email', 'Signed In', 'Created', 'Status', 'Roles', 'External User?']
    end

    def process_records(records)
      records
    end

    def write_attributes
      user_type = current_record.external? ? 'Yes' : 'No'

      [current_record.to_s,
       current_record.email,
       format_datetime(current_record.current_sign_in_at),
       format_date(current_record.created_at),
       current_record.user_status.to_s,
       current_record.security_roles.map(&:name).join('/'),
       user_type]
    end

    def reset_attributes; end
end
