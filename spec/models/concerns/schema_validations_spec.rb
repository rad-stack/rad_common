require 'rails_helper'

describe 'SchemaValidations', type: :module do
  let(:division) { create :division }
  subject { division.errors.full_messages }

  context 'presence validations' do
    context 'text field' do
      before { division.update(name: nil) }

      it { is_expected.to include "Name can't be blank" }
    end
  end
end
