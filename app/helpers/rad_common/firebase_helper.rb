module RadCommon
  module FirebaseHelper
    def firebase_logs_actions(log)
      return unless policy(Company.main).update?

      [link_to('Delete All',
               firebase_log_path(log.first, type: 'all'),
               method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger btn-sm'),
       link_to('Delete Non Errors',
               firebase_log_path(log.first, type: 'non_errors'),
               method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger btn-sm')]
    end

    def firebase_log_rows(log)
      log.last.to_a.map do |item|
        { key: item.first, timestamp: item.last['timestamp'], error: item.last['error'], log: item.last }
      end.sort_by { |item| item[:timestamp] }.reverse
    end
  end
end
