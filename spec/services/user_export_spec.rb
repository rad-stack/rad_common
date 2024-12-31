require 'rails_helper'

RSpec.describe UserExport, type: :service do
  RSpec::Matchers.define :have_expected_export_content do |expected_user|
    match do |actual_content|
      actual_content.include?(expected_user.to_s) &&
        actual_content.include?(expected_user.email) &&
        actual_content.include?(ApplicationController.helpers.format_datetime(expected_user.current_sign_in_at)) &&
        actual_content.include?(ApplicationController.helpers.format_date(expected_user.created_at)) &&
        actual_content.include?(expected_user.user_status.to_s) &&
        actual_content.include?(expected_user.security_roles.map(&:name).join('/')) &&
        actual_content.include?('No')
    end
  end

  describe '.generate' do
    let(:user) { create :user, external: false, current_sign_in_at: Time.current }
    let(:another) { create :user, external: false, current_sign_in_at: Time.current }
    let(:export_format) { :csv }
    let(:exporter) { described_class.new(records: [user, another], current_user: user, format: export_format) }
    let(:file) { exporter.generate }

    context 'when record limit is exceeded' do
      before { stub_const('Exporter::RECORD_LIMIT', 1) }

      it { expect { file }.to raise_error "exporter record limit of 1 exceeded with 2" }
    end

    context 'when CSV format' do
      before { exporter.send(:headers).each { |heading| expect(file).to include(heading) } }

      it 'generates an export csv file with expected content' do
        expect(file).to have_expected_export_content(user)
      end
    end

    context 'when PDF format' do
      let(:export_format) { :pdf }

      it 'generates an export pdf file with expected content' do
        expect(file).to start_with('%PDF-1.')
        pdf_text = PDF::Reader.new(StringIO.new(file)).pages.map(&:text).join(' ')

        expect(pdf_text).to have_expected_export_content(user)
      end
    end
  end
end
