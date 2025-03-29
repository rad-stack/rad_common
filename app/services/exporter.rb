class Exporter
  include RadCommon::ApplicationHelper
  include EnumsHelper
  include ActionView::Helpers::NumberHelper

  attr_reader :records, :current_record, :current_user, :format

  DEFAULT_FORMAT = :csv
  HARD_RECORD_LIMIT = 100_000

  def initialize(records:, current_user:, format: DEFAULT_FORMAT)
    @records = records
    @current_user = current_user
    @current_record = nil
    @format = format

    return unless record_count > HARD_RECORD_LIMIT

    # this is an arbitrary limit that could be increased if we start hitting it regularly
    raise "exporter record limit of #{HARD_RECORD_LIMIT} exceeded with #{record_count}"
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

      pdf.image Rails.root.join('app', 'assets', 'images', RadConfig.app_logo_filename!),
                position: :left,
                width: 150

      pdf.move_down 5
      pdf.text report_name, align: :center, style: :bold, size: 24
      pdf.move_down 10

      data = records.map do |record|
        @current_record = record
        reset_attributes
        # TODO: Consider adding global font that supports more UTF-8 characters
        write_attributes.map do |cell|
          cell.to_s.encode('Windows-1252', invalid: :replace, undef: :replace, replace: '')
        end
      end

      pdf.table([headers] + data, header: true, width: pdf.bounds.width)

      pdf.render
    end

    def report_name
      "#{records.klass.name} Export"
    end

    def record_count
      @record_count ||= records.size.is_a?(Hash) ? 1 : records.size
    end
end
