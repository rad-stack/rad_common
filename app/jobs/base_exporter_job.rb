class BaseExporterJob < ApplicationJob
  queue_as :default

  attr_reader :params, :user_id, :format

  def perform(params, user_id, format: Exporter::DEFAULT_FORMAT)
    @params = params
    @user_id = user_id
    @format = format

    if exporter.soft_record_limit?
      RadMailer.simple_message(user, "#{report_name}: Limit Exceeded", export_limit_body).deliver_now
    else
      RadMailer.email_report(user, export, report_name, report_options(params).merge(format: format)).deliver_now
    end
  end

  def report_options(_params)
    {}
  end

  private

    def export_limit_body
      "Your export request for #{report_name} exceeds the #{exporter.soft_record_limit} record limit and can’t be " \
        'processed. Please refine your query by applying more filters or narrowing the date range, then try again. ' \
        'Let us know if you need help, we can try increasing the limit.'
    end

    def export
      @export ||= exporter.generate
    end

    def user
      @user ||= User.find(user_id)
    end
end
