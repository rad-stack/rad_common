require 'rails_helper'

RSpec.describe Attorney do
  describe 'auditing rich text fields' do
    let(:attorney) { create :attorney }
    let(:rich_text_audit) { Audited::Audit.where(auditable_type: 'ActionText::RichText').last }

    it 'creates audits for the attorney and the rich text' do
      expect { attorney.update!(notes: 'Rich text content') }.to change(Audited::Audit, :count).by(2)
      expect(rich_text_audit.auditable.record).to eq(attorney)
      expect(rich_text_audit.audited_changes['body']).to include('Rich text content')
      expect(rich_text_audit.audited_changes['body']).to include('<div class="lexxy-content">')
    end
  end
end
