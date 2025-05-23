class Exporter
  include RadCommon::ApplicationHelper
  include EnumsHelper
  include ActionView::Helpers::NumberHelper

  attr_reader :records, :current_record, :current_user, :format

  DEFAULT_FORMAT = :csv
  HARD_RECORD_LIMIT = 50_000

  def initialize(records:, current_user:, format: DEFAULT_FORMAT)
    @records = records
    @current_user = current_user
    @current_record = nil
    @format = format

    return unless record_count > HARD_RECORD_LIMIT

    # this is an arbitrary limit that could be increased if we start hitting it regularly
    # soft limits can also be added on a per exporter basis by overriding the soft_record_limit method

    raise "exporter record limit of #{HARD_RECORD_LIMIT} exceeded with #{record_count}"
  end

  def soft_record_limit?
    soft_record_limit.present? && record_count > soft_record_limit
  end

  def soft_record_limit
    # override this in subclasses as needed
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

      pdf.image Company.main.pdf_app_logo,
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
