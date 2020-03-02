require 'rails_helper'

RSpec.describe 'Attachments', type: :request do
  let(:user) { create :admin }
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

  describe 'DELETE destroy' do
    let(:audit) { division.own_and_associated_audits.reorder(id: :desc).first }

    before { login_as user, scope: :user }

    it 'destroys the attachment, redirects to the division and adds audit' do
      expect {
        delete "/rad_common/attachments/#{division.logo.id}"
      }.to change(ActiveStorage::Attachment, :count).by(-1)

      expect(response).to redirect_to(division_url(division))
      expect(audit.action).to eq 'destroy'
    end
  end
end
