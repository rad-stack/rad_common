require 'rails_helper'

RSpec.describe Attorney do
  describe 'auditing rich text fields' do
    let(:attorney) { create :attorney }
    let(:rich_text_audit) { Audited::Audit.where(auditable_type: 'ActionText::RichText').last }

    it 'creates audits for the attorney and the rich text' do
      expect { attorney.update!(notes: 'Rich text content') }.to change(Audited::Audit, :count).by(2)
      expect(rich_text_audit.auditable.record).to eq(attorney)
      expect(rich_text_audit.audited_changes['body']).to include('Rich text content')
      expect(rich_text_audit.audited_changes['body']).to include('<div class="trix-content">')
    end
  end

  describe 'validations' do
    let(:first_name) { 'John' }
    let(:last_name) { 'Smith' }
    let(:mobile_phone) { '(999) 999-9999' }

    before { create :attorney, first_name: first_name, last_name: last_name, mobile_phone: mobile_phone }

    it 'allows multiple attorneys same first and last name, without mobile phone' do
      create :attorney, first_name: first_name, last_name: last_name, mobile_phone: nil
      expect(build(:attorney, first_name: first_name, last_name: last_name, mobile_phone: nil)).to be_valid
    end

    it "doesn't allow multiple attorneys with the same first, last, and mobile phone" do
      expect(build(:attorney, first_name: first_name, last_name: last_name, mobile_phone: mobile_phone)).not_to be_valid
    end
  end
end
