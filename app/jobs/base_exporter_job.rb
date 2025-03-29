class BaseExporterJob < ApplicationJob
  queue_as :default

  attr_reader :params, :user_id, :format

  def perform(params, user_id, format: Exporter::DEFAULT_FORMAT)
    @params = params
    @user_id = user_id
    @format = format

    RadMailer.email_report(user, export, report_name, report_options(params).merge(format: format)).deliver_now
  end

  def report_options(_params)
    {}
  end

  private

    def export
      @export ||= exporter.generate
    end

    def user
      @user ||= User.find(user_id)
    end
end
