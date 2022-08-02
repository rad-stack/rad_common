require 'rails_helper'

RSpec.describe Contactable do
  describe 'standardize_address', :vcr do
    subject(:company) { Company.main }

    describe 'with smarty', smarty_specs: true do
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
          expect(company.address_2).to be_nil
          expect(company.city).to eq('Orlando')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => '4000 Central Florida Boulevard' })
        end
      end

      context 'with zip+4' do
        let(:address_1) { '8110 Mittie Ave' }
        let(:address_2) { nil }
        let(:city) { 'Panama City' }
        let(:state) { 'FL' }
        let(:zipcode) { '32404-0000' }

        it 'standardizes' do
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
          expect(company.zipcode).to eq('32404')
        end
      end

      context 'with enhanced matching' do
        let(:address_1) { '6450 Autumn Berry Cirlce' }
        let(:address_2) { nil }
        let(:city) { 'Jacksonville' }
        let(:state) { 'FL' }
        let(:zipcode) { '32258' }

        it 'standardizes' do
          expect(company.address_1).to eq('6450 Autumn Berry Cir')
          expect(company.address_problems).to be_nil
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
          expect(company.address_2).to be_nil
          expect(company.city).to eq('Jacksonville')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32205')
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => '1376 Macarthur Street' })
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
          expect(company.address_2).to be_nil
          expect(company.city).to eq('Orlando')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32815')
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => 'Post Office Box 39', 'zipcode' => '32816' })
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
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => '4000 Central Florida Boulevard',
                                                  'address_2' => 'Suite 1000' })
        end
      end

      context 'with not deliverable' do
        let(:address_1) { '4000 Bro Bruh' }
        let(:address_2) { nil }
        let(:city) { 'Mordor' }
        let(:state) { 'FL' }
        let(:zipcode) { '32816' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to eq 'invalid address'
          expect(company.address_1).to eq(address_1)
          expect(company.address_changes).to be_nil
        end
      end

      context 'with missing secondary component' do
        let(:address_1) { '3615 Dupont Avenue' }
        let(:address_2) { nil }
        let(:city) { 'Jacksonville' }
        let(:state) { 'FL' }
        let(:zipcode) { '32217' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to eq 'missing suite or unit #'
        end
      end
    end

    describe 'with lob', lob_specs: true do
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
          expect(company.address_2).to be_nil
          expect(company.city).to eq('ORLANDO')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32816')
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => '4000 Central Florida Boulevard' })
        end
      end

      context 'with zip+4' do
        let(:address_1) { '8110 Mittie Ave' }
        let(:address_2) { nil }
        let(:city) { 'Panama City' }
        let(:state) { 'FL' }
        let(:zipcode) { '32404-0000' }

        it 'standardizes' do
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
          expect(company.zipcode).to eq('32404')
        end
      end

      context 'with enhanced matching' do
        let(:address_1) { '6450 Autumn Berry Cirlce' }
        let(:address_2) { nil }
        let(:city) { 'Jacksonville' }
        let(:state) { 'FL' }
        let(:zipcode) { '32258' }

        it 'standardizes' do
          expect(company.address_1).to eq('6450 AUTUMN BERRY CIR')
          expect(company.address_problems).to be_nil
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
          expect(company.address_2).to be_nil
          expect(company.city).to eq('ORLANDO')
          expect(company.state).to eq('FL')
          expect(company.zipcode).to eq('32815')
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => 'Post Office Box 39', 'zipcode' => '32816' })
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
          expect(company.address_problems).to be_nil
          expect(company.address_changes).to eq({ 'address_1' => '4000 Central Florida Boulevard',
                                                  'address_2' => 'Suite 1000' })
        end
      end

      context 'with not deliverable' do
        let(:address_1) { '4000 Bro Bruh' }
        let(:address_2) { nil }
        let(:city) { 'Mordor' }
        let(:state) { 'FL' }
        let(:zipcode) { '32816' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to eq 'undeliverable'
          expect(company.address_1).to eq(address_1)
          expect(company.address_changes).to be_nil
        end
      end

      context 'with missing secondary component' do
        let(:address_1) { '3615 Dupont Avenue' }
        let(:address_2) { nil }
        let(:city) { 'Jacksonville' }
        let(:state) { 'FL' }
        let(:zipcode) { '32217' }

        it 'sets address_problems and does not touch address' do
          expect(company.address_problems).to eq 'missing suite or unit #'
        end
      end
    end
  end
end
