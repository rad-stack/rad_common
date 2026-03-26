require 'rails_helper'

RSpec.describe 'AssistantSessions', :js do
  let(:admin) { create :admin }
  let!(:john) { create :user, first_name: 'John', last_name: 'Doe' }
  let!(:jane) { create :user, first_name: 'Jane', last_name: 'Smith' }

  before do
    login_as admin, scope: :user
  end

  describe 'chat mentions' do
    def type_in_contenteditable(element, text)
      element.click
      # Type all at once using JavaScript, placing cursor at end
      page.execute_script(<<~JS, element, text)
        var el = arguments[0];
        var text = arguments[1];
        el.textContent = text;

        // Place cursor at the end of the text
        var range = document.createRange();
        var sel = window.getSelection();
        range.selectNodeContents(el);
        range.collapse(false); // false = collapse to end
        sel.removeAllRanges();
        sel.addRange(range);

        el.dispatchEvent(new InputEvent('input', { bubbles: true }));
      JS
    end

    def press_key(element, key)
      page.execute_script(<<~JS, element, key)
        var el = arguments[0];
        var key = arguments[1];
        var event = new KeyboardEvent('keydown', {
          key: key,
          code: key,
          bubbles: true,
          cancelable: true
        });
        el.dispatchEvent(event);
      JS
    end

    def open_chat_modal
      visit assistant_sessions_path
      click_button 'Ask Assistant?'
      find_by_id('assistant_session_current_message')
    end

    def find_mention_item(expected_user)
      # Find with long wait - combines waiting for dropdown and finding item
      find('.mention-dropdown .mention-item', text: expected_user.to_s, wait: 10)
    end

    it 'shows mention dropdown when typing @' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@john')

      expect(page).to have_css('.mention-dropdown .mention-item', text: john.to_s, wait: 10)
    end

    it 'filters mentions based on query' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@jane')

      expect(page).to have_css('.mention-dropdown .mention-item', text: jane.to_s, wait: 10)
      expect(page).to have_no_css('.mention-item', text: john.to_s)
    end

    it 'selects mention with click' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@john')

      mention_item = find_mention_item(john)
      page.execute_script('arguments[0].click()', mention_item)

      expect(page).to have_css('.mention', text: "@#{john}", wait: 5)
    end

    it 'selects mention with Enter key' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@john')

      find_mention_item(john)
      press_key(input, 'Enter')

      expect(page).to have_css('.mention', text: "@#{john}", wait: 5)
    end

    it 'navigates mentions with arrow keys' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@')
      sleep 0.5

      # Dropdown shouldn't show yet (minChars is 2)
      expect(page).to have_css('.mention-dropdown.d-none', visible: :all)
    end

    it 'closes dropdown with Escape key' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@john')

      find_mention_item(john)
      press_key(input, 'Escape')

      expect(page).to have_css('.mention-dropdown.d-none', visible: :all, wait: 5)
    end

    it 'hides dropdown when query is too short' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      type_in_contenteditable(input, '@j')
      sleep 0.5

      # Query is only 1 char, minChars is 2, so dropdown should stay hidden
      expect(page).to have_css('.mention-dropdown.d-none', visible: :all)
    end

    it 'shows placeholder hint about mentions' do
      open_chat_modal
      input = find_by_id('assistant_session_current_message')
      expect(input['data-placeholder']).to include('use @ to mention')
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
