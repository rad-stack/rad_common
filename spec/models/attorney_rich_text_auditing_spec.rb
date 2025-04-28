require 'rails_helper'

RSpec.describe Attorney do
  describe 'auditing rich text fields' do
    subject(:update_notes) { attorney.update!(notes: 'Rich text content') }

    let(:attorney) { create :attorney }

    it 'creates audits for the attorney and the rich text' do
      expect { update_notes }.to change(Audited::Audit, :count).by(2)

      rich_text_audit = Audited::Audit.where(auditable_type: 'ActionText::RichText').last

      expect(rich_text_audit.auditable.record).to eq(attorney)
      expect(rich_text_audit.audited_changes['body']).to include('Rich text content')
      expect(rich_text_audit.audited_changes['body']).to include('<div class="trix-content">')
    end
  end
end
