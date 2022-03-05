class Exporter
  include RadCommon::ApplicationHelper
  attr_reader :records, :current_record

  def initialize(records:)
    @records = records
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
end
