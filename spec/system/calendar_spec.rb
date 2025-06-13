require 'rails_helper'

RSpec.describe 'Calendar' do
  let(:user) { create :admin }
  let(:division) { create :division }

  before { login_as user, scope: :user }

  it 'shows the calendar', :js do
    visit calendar_divisions_path

    expect(page).to have_content('today')
    expect(page).to have_content('month')
    expect(page).to have_content('week')
    expect(page).to have_content('day')
  end
end
