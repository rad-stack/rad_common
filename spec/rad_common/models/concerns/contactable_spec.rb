require 'rails_helper'

RSpec.describe Contactable do
  describe 'standardize_address', :vcr do
    subject(:company) { Company.main }

    describe 'with smarty' do
      before do
        allow_any_instance_of(described_class).to receive(:address_api_class_name).and_return('SmartyAddress')

        company.update! bypass_address_validation: false,
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
          expect(company.address_1).to eq('4000 Central Florida Blvd')
          expect(company.address_2).to be nil
          expect(company.city).to eq('Orlando')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be false
        end
      end

      context 'with mixed case address' do
        let(:address_1) { '1376 Macarthur Street' }
        let(:address_2) { nil }
        let(:city) { 'JacksonvillE' }
        let(:state) { 'fL' }
        let(:zipcode) { '32205' }

        it 'standardizes' do
          expect(company.address_1).to eq('1376 MacArthur St')
          expect(company.address_2).to be nil
          expect(company.city).to eq('Jacksonville')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32205')
          expect(company.address_problems).to be false
        end
      end

      context 'with post office box' do
        let(:address_1) { 'Post Office Box 39' }
        let(:address_2) { nil }
        let(:city) { 'OrLando' }
        let(:state) { 'fl' }
        let(:zipcode) { '32816' }

        it 'standardizes' do
          expect(company.address_1).to eq('PO Box 39')
          expect(company.address_2).to be nil
          expect(company.city).to eq('Orlando')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32815')
          expect(company.address_problems).to be false
        end
      end

      context 'with Secondary Address' do
        let(:address_1) { '4000 Central Florida Boulevard' }
        let(:address_2) { 'Suite 1000' }
        let(:city) { 'OrLando' }
        let(:state) { 'fl' }
        let(:zipcode) { '32816' }

        it 'standardizes' do
          expect(company.address_1).to eq('4000 Central Florida Blvd')
          expect(company.address_2).to eq('Ste 1000')
          expect(company.city).to eq('Orlando')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be false
        end
      end

      context 'with not deliverable' do
        let(:address_1) { '4000 Bro Bruh' }
        let(:address_2) { nil }
        let(:city) { 'Mordor' }
        let(:state) { 'FL' }
        let(:zipcode) { '32816' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to be true
          expect(company.address_1).to eq(address_1)
        end
      end
    end

    describe 'with lob' do
      before do
        allow_any_instance_of(described_class).to receive(:address_api_class_name).and_return('LobAddress')

        company.update! bypass_address_validation: false,
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
        let(:state) { 'FL' }
        let(:zipcode) { '32816' }

        it 'standardizes' do
          expect(company.address_1).to eq('4000 CENTRAL FLORIDA BLVD')
          expect(company.address_2).to be nil
          expect(company.city).to eq('ORLANDO')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be false
        end
      end

      context 'with post office box' do
        let(:address_1) { 'Post Office Box 39' }
        let(:address_2) { nil }
        let(:city) { 'OrLando' }
        let(:state) { 'fl' }
        let(:zipcode) { '32816' }

        it 'standardizes' do
          expect(company.address_1).to eq('PO BOX 39')
          expect(company.address_2).to be nil
          expect(company.city).to eq('ORLANDO')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32815')
          expect(company.address_problems).to be false
        end
      end

      context 'with Secondary Address' do
        let(:address_1) { '4000 Central Florida Boulevard' }
        let(:address_2) { 'Suite 1000' }
        let(:city) { 'OrLando' }
        let(:state) { 'fl' }
        let(:zipcode) { '32816' }

        it 'standardizes' do
          expect(company.address_1).to eq('4000 CENTRAL FLORIDA BLVD')
          expect(company.address_2).to eq('STE 1000')
          expect(company.city).to eq('ORLANDO')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be false
        end
      end

      context 'with not deliverable' do
        let(:address_1) { '4000 Bro Bruh' }
        let(:address_2) { nil }
        let(:city) { 'Mordor' }
        let(:state) { 'FL' }
        let(:zipcode) { '32816' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to be true
          expect(company.address_1).to eq(address_1)
        end
      end
    end
  end
end