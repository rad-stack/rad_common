require 'csv'

class Exporter
  include RadCommon::ApplicationHelper
  attr_reader :records, :current_record, :current_user

  DEFAULT_FORMAT = :csv

  def initialize(records:, current_user:)
    @records = records
    @current_user = current_user
    @current_record = nil
  end

  def generate
    @records = process_records(@records)
    CSV.generate do |csv|
      csv << headers
      records.each do |record|
        @current_record = record
        reset_attributes
        csv << write_attributes
      end
    end
  end

  private

    def format_boolean(value)
      value ? 'yes' : 'no'
    end
end
