require 'rails_helper'

RSpec.describe Contactable do
  describe 'zipcode validation' do
    subject { company.valid? }

    let(:company) { Company.main }

    before do
      company.state = 'FL'
      company.zipcode = zipcode
    end

    context 'with valid zipcode' do
      let(:zipcode) { '96818' }

      it { is_expected.to be true }
    end

    context 'with extra spaces' do
      let(:zipcode) { ' 96818' }

      it { is_expected.to be true }
    end

    context 'with invalid characters' do
      let(:zipcode) { '9681A' }

      it { is_expected.to be false }
    end

    context 'with not enough characters' do
      let(:zipcode) { '9681' }

      it { is_expected.to be false }
    end

    context 'with too many characters' do
      let(:zipcode) { '968189' }

      it { is_expected.to be false }
    end

    context 'with canadian' do
      let(:zipcode) { 'H4K 1M9' }

      it { is_expected.to be false }
    end
  end

  describe 'standardize_address', :smarty_specs, :vcr do
    subject(:company) { Company.main }

    before do
      allow(RadConfig).to receive(:canadian_addresses?).and_return true

      company.update bypass_address_validation: false,
                     address_1: address_1,
                     address_2: address_2,
                     city: city,
                     state: state,
                     zipcode: zipcode
    end

    context 'with standard address' do
      let(:address_1) { '4000 Central Florida Boulevard' }
      let(:address_2) { nil }
      let(:city) { 'OrLando' }
      let(:state) { 'fl' }
      let(:zipcode) { '32816' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.address_1).to eq('4000 Central Florida Blvd')
        expect(company.address_2).to be_nil
        expect(company.city).to eq('Orlando')
        expect(company.state).to eq('FL')
        expect(company.zipcode).to eq('32816')
        expect(company.address_problems).to be_nil
        expect(company.address_changes).to eq('4000 Central Florida Boulevard')
      end
    end

    context 'with zip+4' do
      let(:address_1) { '8110 Mittie Ave' }
      let(:address_2) { nil }
      let(:city) { 'Panama City' }
      let(:state) { 'FL' }
      let(:zipcode) { '32404-0000' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.zipcode).to eq('32404-5273')
      end
    end

    context 'with invalid zip+4' do
      let(:address_1) { '8110 Mittie Ave' }
      let(:address_2) { nil }
      let(:city) { 'Panama City' }
      let(:state) { 'FL' }
      let(:zipcode) { '32404-333' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.zipcode).to eq('32404')
      end
    end

    context 'with enhanced matching' do
      let(:address_1) { '11556 Braddock Road' }
      let(:address_2) { nil }
      let(:city) { 'Dinsmore' }
      let(:state) { 'FL' }
      let(:zipcode) { '32219' }

      it 'standardizes' do
        company
        expect(company.valid?).to be true
        expect(company.address_1).to eq('11556 Braddock Rd')

        # if we need to re-record and find another example address, you can search through a client's database
        # looking for this message in address_problems
        expect(company.address_problems).to eq 'non-postal match using enhanced address matching'
      end
    end

    context 'with enhanced matching and nil dpv_match_code' do
      let(:address_1) { '331 Theater Rd' }
      let(:address_2) { nil }
      let(:city) { 'Onalaska' }
      let(:state) { 'WI' }
      let(:zipcode) { '54650' }

      it 'is valid' do
        expect(company.valid?).to be true
      end
    end

    context 'with mixed case address' do
      let(:address_1) { '1376 Macarthur Street' }
      let(:address_2) { nil }
      let(:city) { 'JacksonvillE' }
      let(:state) { 'fL' }
      let(:zipcode) { '32205' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.address_1).to eq('1376 MacArthur St')
        expect(company.address_2).to be_nil
        expect(company.city).to eq('Jacksonville')
        expect(company.state).to eq('FL')
        expect(company.zipcode).to eq('32205')
        expect(company.address_problems).to be_nil
        expect(company.address_changes).to eq('1376 Macarthur Street')
      end
    end

    context 'with post office box' do
      let(:address_1) { 'Post Office Box 39' }
      let(:address_2) { nil }
      let(:city) { 'OrLando' }
      let(:state) { 'fl' }
      let(:zipcode) { '32815' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.address_1).to eq('PO Box 39')
        expect(company.address_2).to be_nil
        expect(company.city).to eq('Orlando')
        expect(company.state).to eq('FL')
        expect(company.zipcode).to eq('32815')
        expect(company.address_problems).to be_nil
        expect(company.address_changes).to eq('Post Office Box 39')
      end
    end

    context 'with Secondary Address' do
      let(:address_1) { '4000 Central Florida Boulevard' }
      let(:address_2) { 'Suite 1000' }
      let(:city) { 'OrLando' }
      let(:state) { 'fl' }
      let(:zipcode) { '32816' }

      it 'standardizes' do
        expect(company.valid?).to be true
        expect(company.address_1).to eq('4000 Central Florida Blvd')
        expect(company.address_2).to eq('Ste 1000')
        expect(company.city).to eq('Orlando')
        expect(company.state).to eq('FL')
        expect(company.zipcode).to eq('32816')
        expect(company.address_problems).to be_nil
        expect(company.address_changes).to eq('4000 Central Florida Boulevard, Suite 1000')
      end
    end

    context 'with not deliverable' do
      let(:address_1) { '4000 Bro Bruh' }
      let(:address_2) { nil }
      let(:city) { 'Mordor' }
      let(:state) { 'FL' }
      let(:zipcode) { '32751' }

      it 'fails validation' do
        expect(company.valid?).to be false
        expect(company.errors.full_messages).to include 'Address 1 is not a valid address'
      end
    end

    context 'with missing secondary component' do
      let(:address_1) { '3615 Dupont Avenue' }
      let(:address_2) { nil }
      let(:city) { 'Jacksonville' }
      let(:state) { 'FL' }
      let(:zipcode) { '32217' }

      it 'sets address_problems and does not touch address' do
        expect(company.valid?).to be true

        # if we need to re-record and find another example address, you can search through a client's database
        # looking for this message in address_problems
        expect(company.address_problems).to eq 'missing suite or unit #'
      end
    end

    context 'with invalid secondary component' do
      let(:address_1) { '1921 East 24th Street' }
      let(:address_2) { 'Apt #1' }
      let(:city) { 'Oakland' }
      let(:state) { 'CA' }
      let(:zipcode) { '94600' }

      it 'confirms address by ignoring secondary component' do
        expect(company.valid?).to be true
        expect(company.address_1).to eq('1921 E 24th St')
        expect(company.address_2).to eq('Apt 1')

        # if we need to re-record and find another example address, you can search through a client's database
        # looking for this message in address_problems
        expect(company.address_problems).to eq 'verified by ignoring invalid suite or unit #'
      end
    end

    context 'with canadian address' do
      let(:address_1) { '12200 Boulevard Laurentien' }
      let(:address_2) { nil }
      let(:city) { 'Montreal' }
      let(:state) { 'QC' }
      let(:zipcode) { 'H4K 1M9' }
    end
  end
end
