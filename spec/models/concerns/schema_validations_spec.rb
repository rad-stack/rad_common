require 'rails_helper'

describe 'SchemaValidations', type: :module do
  subject { division.errors.full_messages }

  let(:division) { create :division }
  let(:category) { create :category }

  describe 'presence validations' do
    context 'with text field' do
      before { division.update(name: nil) }

      it { is_expected.to include "Name can't be blank" }
    end

    context 'with numeric field' do
      before { division.update(hourly_rate: nil) }

      it { is_expected.to include "Hourly rate can't be blank" }
    end

    context 'with boolean field' do
      before { division.update(notify: nil) }

      it { is_expected.to include "Notify can't be blank" }
    end

    context 'with association' do
      before { division.update(owner: nil) }

      it { is_expected.to include 'Owner must exist' }
      it { is_expected.not_to include "Owner can't be blank" }
    end

    context 'with custom options' do
      subject { category.errors.full_messages }

      before { category.update(name: '') }

      it { is_expected.to include 'Name cannot be left blank' }
    end
  end

  describe 'numericality validations' do
    context 'when not a number' do
      before { division.update(hourly_rate: 'string') }

      it { is_expected.to include 'Hourly rate is not a number' }
    end

    context 'when decimal value outside of precision range' do
      before { division.update(hourly_rate: 1_000_000_000) }

      it { is_expected.to include 'Hourly rate must be less than 1000000' }
    end
  end

  describe 'reasonable date range validations' do
    let(:division) { create :division }
    let(:company) { Company.main }

    it 'validates dates' do
      [[200.years.ago, false],
       [200.years.from_now, false],
       [nil, true],
       [2.years.ago, true]].each do |item|
        division.date_established = item.first
        expect(division.valid?).to be item.last
      end
    end

    it 'validates datetimes' do
      [[200.years.ago, false],
       [200.years.from_now, false],
       [nil, true],
       [2.years.ago, true]].each do |item|
        company.validity_checked_at = item.first
        expect(company.valid?).to be item.last
      end
    end

    it 'only validates when field is changed' do
      division.update_column :date_established, 200.years.ago
      expect(division.reload.valid?).to be true
    end
  end

  describe 'exempt columns' do
    it 'raises an error if exempt column fails database constraint' do
      expect { division.update!(created_at: nil) }.to raise_error ActiveRecord::NotNullViolation
    end
  end

  describe 'array columns' do
    let(:company) { Company.main }

    it 'allows empty array' do
      company.update(valid_user_domains: [])
      expect(company.errors.full_messages).not_to include("Valid User Email Domains can't be blank")
      company.update(valid_user_domains: nil)
      expect(company.errors.full_messages).to include("Valid User Email Domains can't be blank")
    end
  end

  describe 'unique index validations' do
    subject { user_status.errors.full_messages }

    let(:user_status) { create :user_status }

    before { user_status.update(name: UserStatus.first.name) }

    it { is_expected.to include 'Name has already been taken' }

    context 'with custom options' do
      let(:dup_category) { build :category, name: category.name }

      before { dup_category.save }

      it { expect(dup_category.errors.full_messages).to include 'Name taken by another category' }
    end

    context 'when index is skipped' do
      let(:division) { create :division, division_status: 'status_pending' }
      let(:division_2) { create :division, division_status: 'status_pending' }
      let(:division_3) { create :division, division_status: 'status_active' }

      before do
        division_2.update(name: division.name)
        division_3.update(name: division.name)
      end

      it 'does not add validation based on schema' do
        expect(division_2.errors.full_messages).to include 'Name has already been taken for a pending division'
        expect(division_2.errors.full_messages).not_to include 'Name has already been taken'
        expect(division_3).to be_valid
      end
    end
  end

  describe 'unique validations multiple columns nulls distinct' do
    let(:first_name) { 'John' }
    let(:last_name) { 'Smith' }
    let(:mobile_phone) { '(999) 999-9999' }
    let(:new_attorney) do
      build :attorney, first_name: other_first_name, last_name: other_last_name, mobile_phone: other_phone
    end

    before do
      create :attorney, first_name: first_name, last_name: last_name, mobile_phone: mobile_phone
      create :attorney, first_name: other_first_name, last_name: other_last_name, mobile_phone: other_phone
    end

    context 'when first_name[nil], last_name[nil], mobile_phone[nil]' do
      let(:other_first_name) { nil }
      let(:other_last_name) { nil }
      let(:other_phone) { nil }

      it 'allows multiples' do
        expect(new_attorney).to be_valid
      end
    end

    context 'when first_name[present], last_name[nil], mobile_phone[nil]' do
      let(:other_first_name) { first_name }
      let(:other_last_name) { nil }
      let(:other_phone) { nil }

      it 'allows multiples' do
        expect(new_attorney).to be_valid
      end
    end

    context 'when first_name[present], last_name[present], mobile_phone[nil]' do
      let(:other_first_name) { first_name }
      let(:other_last_name) { last_name }
      let(:other_phone) { nil }

      it 'allows multiples' do
        create :attorney, first_name: first_name, last_name: last_name, mobile_phone: nil
        expect(new_attorney).to be_valid
      end
    end
  end

  describe 'unique validations multiple columns nulls not distinct' do
    let(:name) { 'My Test Client' }
    let(:business_type) { 'Printing' }

    before { create :client, name: name, business_type: business_type }

    it 'does not allow multiple clients with same name' do
      create :client, name: name, business_type: nil
      expect(build(:client, name: name, business_type: nil)).not_to be_valid
    end

    it 'allows multiple clients with different name' do
      create :client, name: name, business_type: nil
      expect(build(:client, name: 'Other Name', business_type: nil)).to be_valid
    end
  end
end
