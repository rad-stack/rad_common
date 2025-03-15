class BaseReport
  include RadCommon::ApplicationHelper

  attr_accessor :current_user, :view_context, :params, :start_date, :end_date, :report_errors

  def initialize(current_user, view_context, params)
    @current_user = current_user
    @view_context = view_context
    @params = params
    @report_errors = []

    return unless date_filters?

    if params[:report].blank?
      @start_date = start_date_default
      @end_date = end_date_default
    else
      begin
        @start_date = params[:report][:start_date]&.to_date
        @end_date = params[:report][:end_date]&.to_date
      rescue ArgumentError
        @report_errors.push 'Invalid date'
      end
    end

    apply_base_errors
  end

  def date_filters?
    true
  end

  def valid?
    report_errors.empty?
  end

  def sub_title
    "#{format_date_long(start_date)} through #{format_date_long(end_date)}"
  end

  def printable?
    false
  end

  def csv_exportable?
    export_job.present?
  end

  def clear_filters_button?
    true
  end

  def csv?
    params[:format] == 'csv'
  end

  def orientation
    'Portrait'.freeze
  end

  def warning_message; end

  def error_message
    report_errors.join(', ')
  end

  def export_job; end

  private

    # Override default start and end dates in sub classes as needed

    def start_date_default
      return unless date_filters?

      beginning_of_last_week
    end

    def end_date_default
      return unless date_filters?

      end_of_last_week
    end

    def beginning_of_last_week
      end_of_last_week.beginning_of_week
    end

    def end_of_last_week
      Date.current.beginning_of_week.advance days: -1
    end

    def beginning_of_last_quarter
      end_of_last_quarter.beginning_of_quarter
    end

    def end_of_last_quarter
      Date.current.beginning_of_quarter.advance days: -1
    end

    def beginning_of_last_month
      end_of_last_month.beginning_of_month
    end

    def end_of_last_month
      Date.current.beginning_of_month.advance days: -1
    end

    def apply_base_errors
      report_errors.push 'Start date is required' if start_date.blank?
      report_errors.push 'End date is required' if end_date.blank?
      return unless start_date.present? && end_date.present? && start_date > end_date

      report_errors.push 'Start date must be before end date'
    end
end
