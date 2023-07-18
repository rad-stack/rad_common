class UserExport < Exporter
  private

    def headers
      items = ['Name', 'Email', 'Signed In', 'Created', 'Status', 'Roles']
      items.push('External User?') if current_user.internal?
      items
    end

    def process_records(records)
      records
    end

    def write_attributes
      items = [current_record.to_s,
               current_record.email,
               format_datetime(current_record.current_sign_in_at),
               format_date(current_record.created_at),
               current_record.user_status.to_s,
               current_record.security_roles.map(&:name).join('/')]

      items.push(current_record.external? ? 'Yes' : 'No') if current_user.internal?

      items
    end

    def reset_attributes; end

    def report_name
      'Users Report'
    end
end
