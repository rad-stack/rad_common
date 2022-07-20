require 'rails_helper'

RSpec.describe Contactable do
  subject(:attorney) { create(:attorney) }

  describe '#standardize_address' do
    let(:return_value) do
      {
        'primary_line' => '4000 CENTRAL FLORIDA BLVD',
        'last_line' => 'ORLANDO FL 32816-8005',
        'deliverability' => 'deliverable',
        'components' =>
         { 'primary_number' => '4000',
           'street_predirection' => '',
           'street_name' => 'CENTRAL FLORIDA',
           'street_suffix' => 'BLVD',
           'street_postdirection' => '',
           'secondary_designator' => '',
           'secondary_number' => '',
           'city' => 'ORLANDO',
           'state' => 'FL',
           'zip_code' => '32816',
           'zip_code_plus_4' => '8005' }
      }
    end

    before do
      allow(RadicalConfig).to receive(:lob_key!).and_return 'foo'
      allow(RadicalConfig).to receive(:lob_key).and_return 'foo'

      us_verifier = double('us_verifier')
      lob_client = double(Lob::Client, us_verifications: us_verifier)
      allow(Lob::Client).to receive(:new).and_return(lob_client)
      allow(us_verifier).to receive(:verify).and_return(return_value)
    end

    it 'standardizes typical address information' do
      attorney.send(:standardize_address)
      expect(attorney.address_1).to eq('4000 CENTRAL FLORIDA BLVD')
      expect(attorney.address_2).to eq('')
      expect(attorney.city).to eq('ORLANDO')
      expect(attorney.state).to eq('FL')
      expect(attorney.zipcode).to eq('32816')
      expect(attorney.address_problems).to be_nil
    end

    context 'with not "deliverable"' do
      let(:return_value) { { 'deliverability' => 'no_match' } }

      it 'sets address_problems and does not touch address' do
        original_subject = attorney.dup
        attorney.send(:standardize_address)
        expect(attorney.address_problems).to eq('no_match')
        expect(attorney.address_1).to eq(original_subject.address_1)
      end
    end

    context 'with P.O. Box' do
      let(:return_value) do
        {
          'deliverability' => 'deliverable',
          'components' =>
           { 'primary_number' => '39',
             'street_predirection' => '',
             'street_name' => 'PO BOX',
             'street_suffix' => 'BLVD',
             'street_postdirection' => '',
             'secondary_designator' => '',
             'secondary_number' => '',
             'extra_secondary_information' => '',
             'city' => 'ORLANDO',
             'state' => 'FL',
             'zip_code' => '32816',
             'zip_code_plus_4' => '8005' }
        }
      end

      it 'sets address_problems and does not touch address' do
        attorney.send(:standardize_address)
        expect(attorney.address_1).to eq('PO BOX 39')
        expect(attorney.address_2).to eq('')
        expect(attorney.city).to eq('ORLANDO')
        expect(attorney.state).to eq('FL')
        expect(attorney.zipcode).to eq('32816')
        expect(attorney.address_problems).to be_nil
      end
    end

    context 'with Secondary Address' do
      let(:return_value) do
        {
          'primary_line' => '4000 CENTRAL FLORIDA BLVD',
          'last_line' => 'ORLANDO FL 32816-8005',
          'deliverability' => 'deliverable',
          'components' =>
           { 'primary_number' => '4000',
             'street_predirection' => '',
             'street_name' => 'CENTRAL FLORIDA',
             'street_suffix' => 'BLVD',
             'street_postdirection' => '',
             'secondary_designator' => 'SUITE',
             'secondary_number' => '1000',
             'city' => 'ORLANDO',
             'state' => 'FL',
             'zip_code' => '32816',
             'zip_code_plus_4' => '8005' }
        }
      end

      it 'standardizes address line 2 information' do
        attorney.send(:standardize_address)
        expect(attorney.address_1).to eq('4000 CENTRAL FLORIDA BLVD')
        expect(attorney.address_2).to eq('SUITE 1000')
        expect(attorney.city).to eq('ORLANDO')
        expect(attorney.state).to eq('FL')
        expect(attorney.zipcode).to eq('32816')
        expect(attorney.address_problems).to be_nil
      end
    end

    context 'when no result' do
      let(:return_value) { nil }

      it 'does nothing' do
        original_subject = attorney.dup
        attorney.send(:standardize_address)
        expect(attorney.address_1).to eq(original_subject.address_1)
        expect(attorney.address_problems).to be_nil
      end
    end
  end
end
