require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let(:user) { create :admin }
  let(:division) { create :division }

  before { login_as user, scope: :user }

  describe 'like filter' do
    it 'should display a text input'
    it 'should retain search value after applying filters'
  end

  describe 'select filter' do
    it 'should display a select input'
    it 'should retain search value after applying filters'
    it 'select should have success style when default value is selected'
    it 'select should have warning style when a value is selected other than default'
  end

  describe 'date filter' do
    it 'should display a start and end inputs'
    it 'should retain search value after applying filters'\
  end
end
