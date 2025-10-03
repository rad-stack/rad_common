class FaxSender
  attr_reader :contact_log

  delegate :send_fax!, to: :sinch_fax_client

  def initialize(contact_log)
    @contact_log = contact_log
  end

  def send!
    response = send_fax!

    update_log(response)
    true
  rescue StandardError => e
    Sentry.capture_exception(e)

    log_event false, nil
    false
  end

  def update_log(response)
    contact_log.update(fax_message_id: response['id'], sent: true)
  end

  private

    def sinch_fax_client
      @sinch_fax_client ||= SinchFaxClient.new(to_number: @to_number, files: files)
    end

    def files
      @files ||= contact_log.attachments.map(&:download)
    end
end
