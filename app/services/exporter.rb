require 'csv'
require 'prawn'
require 'prawn/table'

class Exporter
  include RadCommon::ApplicationHelper
  attr_reader :records, :current_record, :current_user, :format

  DEFAULT_FORMAT = :csv

  def initialize(records:, current_user:, format: DEFAULT_FORMAT)
    @records = records
    @current_user = current_user
    @current_record = nil
    @format = format
  end

  def generate
    @records = process_records(@records)
    format == DEFAULT_FORMAT ? generate_csv : generate_pdf
  end

  private

    def format_boolean(value)
      value ? 'yes' : 'no'
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
      pdf = Prawn::Document.new(page_layout: :landscape, page_size: 'A3', margin: [10, 10, 20, 20])
      pdf.image Rails.root.join('app', 'assets', 'images', RadConfig.app_logo_filename!), position: :left, width: 150
      pdf.move_down 5
      pdf.text report_name, align: :center, style: :bold, size: 24
      pdf.move_down 10

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
end
