require 'rails_helper'

RSpec.describe AttachmentUrlGenerator do
  let(:user) { create :admin }
  let!(:division) { create :division }
  let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/app_logo.png')) }
  let(:include_filename) { false }

  before do
    allow_any_instance_of(Hashids).to receive(:encode).and_return 'dkadnq'
    division.logo.attach(io: file, filename: 'logo.png')
  end

  context 'with permanent attachment url' do
    subject { described_class.permanent_attachment_url(division.logo, include_filename: include_filename) }

    it { is_expected.to eq 'http://localhost:3000/attachments/dkadnq' }

    context 'with filename option' do
      let(:include_filename) { true }

      it { is_expected.to eq 'http://localhost:3000/attachments/dkadnq/logo.png' }
    end
  end

  context 'with permanent attachment variant url' do
    subject { described_class.permanent_attachment_variant_url(division, :logo_variant, include_filename: include_filename) }

    it { is_expected.to eq 'http://localhost:3000/attachments/divisions/dkadnq/logo_variant' }

    context 'with filename option' do
      let(:include_filename) { true }

      it { is_expected.to eq 'http://localhost:3000/attachments/divisions/dkadnq/logo_variant/logo.png' }
    end
  end
end
