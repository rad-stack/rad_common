class BaseReport
  include RadCommon::ApplicationHelper

  attr_accessor :current_user, :view_context, :params, :start_date, :end_date, :invalid_date

  def initialize(current_user, view_context, params)
    @current_user = current_user
    @view_context = view_context
    @params = params
    @invalid_date = false

    if params[:report].blank?
      @start_date = start_date_default
      @end_date = end_date_default
    else
      begin
        @start_date = params[:report][:start_date]&.to_date
        @end_date = params[:report][:end_date]&.to_date
      rescue ArgumentError
        @invalid_date = true
      end
    end
  end

  def valid?
    errors.blank?
  end

  def errors
    return 'Invalid date' if @invalid_date

    items = []

    items.push 'Start date is required' if start_date.blank?
    items.push 'End date is required' if end_date.blank?
    items.push 'Start date must be before end date' if start_date.present? && end_date.present? && start_date > end_date

    items.join(', ')
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

  def warning; end

  def export_job; end

  private

    # Override default start and end dates in sub classes as needed

    def start_date_default
      beginning_of_last_week
    end

    def end_date_default
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

    def end_of_last_month
      Date.current.beginning_of_month.advance days: -1
    end
end
