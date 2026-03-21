require 'rails_helper'

RSpec.describe AttachmentUrlGenerator do
  let(:user) { create :admin }
  let!(:division) { create :division }
  let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/app_logo.png')) }
  let(:include_filename) { false }
  let(:hash_code) { 'dkadnq' }

  before do
    allow_any_instance_of(Hashids).to receive(:encode).and_return hash_code
    division.logo.attach(io: file, filename: 'logo.png')
  end

  context 'with permanent attachment url' do
    subject { described_class.permanent_attachment_url(division.logo, include_filename: include_filename) }

    it { is_expected.to eq "http://localhost:3000/attachments/#{hash_code}" }

    context 'with filename option' do
      let(:include_filename) { true }

      it { is_expected.to eq "http://localhost:3000/attachments/#{hash_code}/logo.png" }
    end
  end

  context 'with permanent attachment variant url' do
    subject do
      described_class.permanent_attachment_variant_url(division,
                                                       :logo_variant,
                                                       include_filename: include_filename)
    end

    it { is_expected.to eq "http://localhost:3000/attachments/divisions/#{hash_code}/logo_variant" }

    context 'with filename option' do
      let(:include_filename) { true }

      it { is_expected.to eq "http://localhost:3000/attachments/divisions/#{hash_code}/logo_variant/logo.png" }
    end
  end
end
