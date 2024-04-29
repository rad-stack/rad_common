class ContactLogSearch < RadCommon::Search
  def initialize(params, current_user)
    @current_user = current_user

    super(query: ContactLogRecipient.joins(:contact_log),
          filters: filters_def,
          sort_columns: sort_columns_def,
          params: params,
          current_user: current_user)
  end

  private

    def filters_def
      items = [{ start_input_label: 'Start Date',
                 end_input_label: 'End Date',
                 column: :created_at,
                 type: RadCommon::DateFilter }]

      if RadConfig.twilio_enabled?
        items += [{ input_label: 'Service Type',
                    name: :service_type,
                    scope_values: enum_scopes(ContactLog, :service_type) },
                  { input_label: 'Log Type',
                    name: :log_type,
                    scope_values: enum_scopes(ContactLog, :sms_log_type) }]
      end

      if RadConfig.twilio_enabled?
        items += [{ input_label: 'From Number',
                    column: 'contact_logs.from_number',
                    type: RadCommon::PhoneNumberFilter,
                    name: :from_number },
                  { input_label: 'To Number',
                    column: 'contact_log_recipients.phone_number',
                    type: RadCommon::PhoneNumberFilter,
                    name: :to_number }]
      end

      items += base_filters

      if RadConfig.twilio_enabled?
        items.push({ input_label: 'SMS Success', name: :status, scope_values: %i[failure successful] })
      end

      items
    end

    def base_filters
      [{ input_label: 'From Email',
         column: 'contact_logs.from_email',
         type: RadCommon::LikeFilter,
         name: :from_email },
       { input_label: 'To Email',
         column: 'contact_log_recipients.email',
         type: RadCommon::LikeFilter,
         name: :to_email },
       { input_label: 'From User',
         column: 'contact_logs.from_user_id',
         options: user_array,
         blank_value_label: 'All Users' },
       { input_label: 'To User',
         column: 'contact_log_recipients.to_user_id',
         options: user_array,
         blank_value_label: 'All Users' },
       { column: 'content', type: RadCommon::LikeFilter }]
    end

    def sort_columns_def
      items = [{ label: 'When', column: 'created_at', direction: 'desc', default: true }]

      if RadConfig.twilio_enabled?
        items += [{ label: 'Service Type', column: 'contact_logs.service_type' },
                  { label: 'Log Type', column: 'contact_logs.sms_log_type' }]
      end

      if RadConfig.twilio_enabled?
        items += [{ label: 'From Number', column: 'contact_logs.from_number' },
                  { label: 'To Number', column: 'contact_log_recipients.phone_number' }]
      end

      items += [{ label: 'From Email', column: 'contact_logs.from_email' },
                { label: 'To Email', column: 'contact_log_recipients.email' },
                { label: 'From User' },
                { label: 'To User' },
                { label: 'Record' },
                { label: 'Content', column: 'contact_logs.content' }]

      if RadConfig.twilio_enabled?
        items += [{ label: 'Opt Out Message Sent?', column: 'contact_logs.sms_opt_out_message_sent' },
                  { label: 'SMS Success', column: 'contact_log_recipients.sms_success' }]
      end

      items
    end

    def user_array
      Pundit.policy_scope!(current_user, User).sorted.pluck(Arel.sql("first_name || ' ' || last_name"), :id)
    end
end
