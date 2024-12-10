module RadCommon
  module SMS
    class IncomingProcessor
      attr_reader :matched_processor

      include Utilities

      COMMAND_PROCESSORS = [OptOut, OptIn].freeze

      def initialize(params)
        @params = params
        @incoming_message = params[:Body]
        @attachments = get_attachments
        @phone_number = Utilities.format_twilio_number(params[:From])
        @command_results = nil
        @sms_reply = nil
        @reply_command = cleanup_command(@incoming_message)
        @matched_processor = nil
      end

      def process
        @command_results = mms? ? process_mms : process_sms
        log_sms! unless mms?
        @sms_reply = @command_results.sms_reply
        return unless @command_results.reply

        after_process
      end

      private

        def process_sms
          @matched_processor = command_processors.find { |processor| processor.matches?(@reply_command) }
          if @matched_processor
            processor = @matched_processor.new(incoming_message: @reply_command,
                                               phone_number: @phone_number,
                                               sms_users: sms_users,
                                               locale: locale)
            return processor.process
          end

          CommandResults.new(command_matched: false, incoming_message: @incoming_message)
        end

        def process_mms
          log_mms!

          CommandResults.new sms_reply: (@log.persisted? ? nil : translate_reply(:communication_mms_failure)),
                             reply: true,
                             incoming_message: @incoming_message.presence || 'MMS',
                             command_matched: false
        end

        def mms?
          @params['MessageSid']&.starts_with? 'M'
        end

        def sms_users
          @sms_users ||= []
        end

        def locale
          'en'
        end

        def command_processors
          COMMAND_PROCESSORS
        end

        def after_process
          send_reply
        end

        def cleanup_command(command)
          command.gsub(/["']/, '').upcase.strip
        end

        def log_sms!
          @log = TwilioLog.create! to_number: RadConfig.twilio_phone_number!,
                                   from_number: @phone_number,
                                   message: @incoming_message
        end

        def get_attachments
          return [] unless mms? && @params['NumMedia'].to_i.positive?

          (0..(@params['NumMedia'].to_i - 1)).map do |counter|
            file = RadicalRetry.perform_request(retry_count: 2) do
              URI.open(@params["MediaUrl#{counter}"], http_basic_authentication: [RadConfig.twilio_account_sid!,
                                                                                  RadConfig.twilio_auth_token!])
            end
            filename = if file.respond_to?(:meta) && file.meta.has_key?('content-disposition')
                         file.meta['content-disposition'].match(/filename="[^"]+"/).to_s.gsub(/filename=|"/, '')
                       else
                         File.basename(file.path)
                       end

            { url: @params["MediaUrl#{counter}"],
              content_type: @params["MediaContentType#{counter}"],
              filename: filename,
              file: file }
          end.compact
        end

        def log_mms!
          @log = TwilioLog.new to_number: RadConfig.twilio_phone_number!,
                               from_number: @phone_number,
                               message: @incoming_message.presence || 'MMS'

          @attachments.each do |attachment|
            @log.media_url = attachment[:url]
            @log.attachments.attach io: attachment[:file],
                                    content_type: attachment[:content_type],
                                    identify: false,
                                    filename: attachment[:filename]
          end

          unless @log.save
            @log.attachments = [] if @log.errors.messages.has_key?(:attachments)
            @log.save
          end

          @log
        end

        def translate_reply(sms_reply_key, params = {})
          params.merge!(locale: locale)
          I18n.t(sms_reply_key, **params)
        end
    end
  end
end
