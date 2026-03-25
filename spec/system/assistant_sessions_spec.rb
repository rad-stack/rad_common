require 'rails_helper'

RSpec.describe 'AssistantSessions', :js do
  let(:admin) { create :admin }
  let!(:john) { create :user, first_name: 'John', last_name: 'Doe' }
  let!(:jane) { create :user, first_name: 'Jane', last_name: 'Smith' }

  before do
    login_as admin, scope: :user
  end

  describe 'chat mentions' do
    it 'shows mention dropdown when typing @' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@john')

        # Wait for debounce (250ms) + API request
        expect(page).to have_css('.mention-dropdown:not(.d-none)', wait: 2)
        expect(page).to have_content(john.to_s)
      end
    end

    it 'filters mentions based on query' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@jane')

        expect(page).to have_css('.mention-dropdown:not(.d-none)', wait: 2)
        expect(page).to have_content(jane.to_s)
        expect(page).to have_no_content(john.to_s)
      end
    end

    it 'selects mention with click' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@john')

        expect(page).to have_css('.mention-dropdown:not(.d-none)', wait: 2)
        find('.mention-item', text: john.to_s).click

        expect(input.value).to include("@#{john}")
      end
    end

    it 'selects mention with Enter key' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@john')

        expect(page).to have_css('.mention-dropdown:not(.d-none)', wait: 2)
        input.send_keys(:enter)

        expect(input.value).to include("@#{john}")
      end
    end

    it 'navigates mentions with arrow keys' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@')
        sleep 0.5

        # Dropdown shouldn't show yet (minChars is 2)
        expect(page).to have_css('.mention-dropdown.d-none', visible: :all)
      end
    end

    it 'closes dropdown with Escape key' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@john')

        expect(page).to have_css('.mention-dropdown:not(.d-none)', wait: 2)

        input.send_keys(:escape)

        expect(page).to have_css('.mention-dropdown.d-none', visible: :all)
      end
    end

    it 'hides dropdown when query is too short' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        input.send_keys('@j')
        sleep 0.5

        # Query is only 1 char, minChars is 2, so dropdown should stay hidden
        expect(page).to have_css('.mention-dropdown.d-none', visible: :all)
      end
    end

    it 'shows placeholder hint about mentions' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        input = find_by_id('assistant_session_current_message')
        expect(input['placeholder']).to include('use @ to mention')
      end
    end
  end

  describe 'chat UI' do
    it 'displays initial greeting from assistant on left side' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        expect(page).to have_css('.chat-left', text: 'Hello, what can I help you with?')
      end
    end

    it 'has submit button and options dropdown' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        expect(page).to have_css('#chat-submit-btn')
        expect(page).to have_css('.dropdown-toggle', text: '...')
      end
    end

    it 'has clear chat option in dropdown' do
      visit assistant_sessions_path
      click_button 'Ask Assistant?'

      within '#basic-question-modal' do
        find('.dropdown-toggle', text: '...').click
        expect(page).to have_button('Clear Chat?')
      end
    end
  end
end
