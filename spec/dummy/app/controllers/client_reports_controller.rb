class ClientReportsController < BaseReportsController
  private

    def authorize_report
      authorize Client.new, :report?
    end

    def set_report
      @report = ClientReport.new(current_user, view_context, params)
    end
end
