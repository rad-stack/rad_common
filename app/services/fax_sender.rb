class FaxSender
  attr_reader :contact_log

  delegate :send_fax!, to: :sinch_fax_client

  DIRECTION = { OUTBOUND: :outgoing, INBOUND: :incoming }.freeze

  def initialize(contact_log)
    @contact_log = contact_log
  end

  def send!
    results = contact_log.contact_log_recipients.map { |recipient| send_to_recipient! recipient }
    results.all? { |r| r == true }
  end

  def send_to_recipient!(recipient)
    response = send_fax!(to_number: recipient.phone_number, files: files)
    update_log!(response)
    true
  rescue StandardError => e
    Sentry.capture_exception(e)
    update_log_failed!(e.message)
    false
  end

  def update_log!(response)
    direction = DIRECTION[response['direction'].to_sym]
    status = response['status'].downcase.to_sym
    contact_log.update!(fax_message_id: response['id'], sent: true, direction: direction)
    contact_log.contact_log_recipients.each do |contact_log_recipient|
      contact_log_recipient.update!(fax_status: status)
    end
  end

  def update_log_failed!(message)
    contact_log.contact_log_recipients.each do |contact_log_recipient|
      contact_log_recipient.update!(fax_status: failure, fax_error_message: message)
    end
  end

  private

    def sinch_fax_client
      @sinch_fax_client ||= SinchFaxClient.new
    end

    def files
      @files ||= contact_log.attachments.map(&:download)
    end
end
