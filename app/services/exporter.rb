require 'csv'

class Exporter
  include RadCommon::ApplicationHelper
  attr_reader :records, :current_record, :current_user, :format

  def initialize(records:, current_user:, format: 'csv')
    @records = records
    @current_user = current_user
    @current_record = nil
    @format = format
  end

  def generate
    @records = process_records(@records)
    format == 'csv' ? generate_csv : generate_pdf
  end

  def generate_csv
    CSV.generate do |csv|
      csv << headers
      records.each do |record|
        @current_record = record
        reset_attributes
        csv << write_attributes
      end
    end
  end

  def generate_pdf
    pdf = Prawn::Document.new(page_size: [841.89, 595.28], margin: [10, 10, 20, 20])
    pdf.image Rails.root.join('app', 'assets', 'images', RadConfig.app_logo_filename!), position: :left, width: 100, height: 100
    pdf.text Company.main.name, align: :left
    pdf.text report_name, align: :left, style: :bold, size: 20

    # Define the table data
    data = records.map do |record|
      @current_record = record
      reset_attributes
      write_attributes
    end

    # Combine the header and data, then draw the table
    pdf.table([headers] + data, header: true)

    pdf.render
  end

  private

    def format_boolean(value)
      value ? 'yes' : 'no'
    end
end
