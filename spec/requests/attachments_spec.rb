require 'rails_helper'

RSpec.describe 'Attachments', type: :request do
  let!(:division) { create :division }
  let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'app_logo.png')) }

  before { division.logo.attach(io: file, filename: 'logo.png') }

  context 'permanent attachment url' do
    it 'allows navigation' do
      get AttachmentUrlGenerator.permanent_attachment_url(division.logo)
      expect(response.status).to eq 200
    end
  end

  context 'permanent attachment variant url' do
    it 'allows navigation' do
      get AttachmentUrlGenerator.permanent_attachment_variant_url(division, :logo_variant)
      expect(response.status).to eq 200
    end
  end
end
