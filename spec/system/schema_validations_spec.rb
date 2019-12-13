require 'rails_helper'

RSpec.describe 'Divisions', type: :system do
  let(:user) { create :admin }

  before { login_as user, scope: :user }

  it 'loads validations when new form renders' do
    expect(Division.validators.map(&:attributes)).not_to include [:code]
    visit new_division_path
    expect(Division.validators.map(&:attributes)).to include [:code]
  end

  it 'loads validations when edit form renders' do
    Object.send(:remove_const, :Division)
    load 'division.rb'
    Division.schema_validations_loaded = true
    division = create(:division)
    Division.schema_validations_loaded = false
    expect(Division.validators.map(&:attributes)).not_to include [:code]
    visit edit_division_path(division)
    expect(Division.validators.map(&:attributes)).to include [:code]
  end
end
