require 'rails_helper'

describe 'SchemaValidations', type: :module do
  subject { division.errors.full_messages }
  let(:division) { create :division }

  describe 'presence validations' do
    context 'text field' do
      before { division.update(name: nil) }

      it { is_expected.to include "Name can't be blank" }
    end

    context 'numeric field' do
      before { division.update(hourly_rate: nil) }

      it { is_expected.to include "Hourly rate can't be blank" }
    end
  end
end
