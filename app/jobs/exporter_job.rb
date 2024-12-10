class ExporterJob < ApplicationJob
  queue_as :default

  def perform(params, user_id)
    search_params = params.include?('search') ? ActionController::Parameters.new(search: params['search']) : {}
    user = User.find(user_id)
    search = search_class.new(search_params, user)
    records = search.results
    export = export_class.new(records: records, current_user: user).generate

    RadbearMailer.email_report(user, export, report_name, report_options(params)).deliver_later
  end

  def report_options(_params)
    {}
  end
end
