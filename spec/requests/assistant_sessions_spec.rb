require 'rails_helper'

RSpec.describe 'AssistantSessions' do
  let(:admin) { create(:admin) }
  let(:assistant_session) { create(:assistant_session, user: admin) }

  before do
    login_as admin, scope: :user
  end

  describe 'GET mentions' do
    let!(:john) { create(:user, first_name: 'John', last_name: 'Smith') }
    let!(:jane) { create(:user, first_name: 'Jane', last_name: 'Doe') }

    context 'with valid query' do
      it 'returns matching users as JSON' do
        get mentions_assistant_session_path(assistant_session), params: { q: 'john', type: 'User' }

        expect(response).to have_http_status(:ok)

        json = response.parsed_body
        expect(json.length).to eq(1)
        expect(json.first['label']).to eq(john.to_s)
        expect(json.first['token']).to eq(john.mention_token)
        expect(json.first['type']).to eq('User')
        expect(json.first['icon']).to eq('user')
      end
    end

    context 'with query matching multiple users' do
      let!(:johnny) { create(:user, first_name: 'Johnny', last_name: 'Test') }

      it 'returns all matching users' do
        get mentions_assistant_session_path(assistant_session), params: { q: 'john', type: 'User' }

        json = response.parsed_body
        labels = json.map { |r| r['label'] }

        expect(labels).to include(john.to_s, johnny.to_s)
        expect(labels).not_to include(jane.to_s)
      end
    end

    context 'with query too short' do
      it 'returns empty array' do
        get mentions_assistant_session_path(assistant_session), params: { q: 'j', type: 'User' }

        expect(response.parsed_body).to eq([])
      end
    end

    context 'with invalid type' do
      it 'returns empty array' do
        get mentions_assistant_session_path(assistant_session), params: { q: 'john', type: 'InvalidType' }

        expect(response.parsed_body).to eq([])
      end
    end

    context 'with empty query' do
      it 'returns empty array' do
        get mentions_assistant_session_path(assistant_session), params: { q: '', type: 'User' }

        expect(response.parsed_body).to eq([])
      end
    end

    context 'when user is not admin' do
      let(:non_admin) { create(:user) }

      before do
        logout
        login_as non_admin, scope: :user
      end

      it 'denies access' do
        get mentions_assistant_session_path(assistant_session), params: { q: 'john', type: 'User' }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET show' do
    it 'renders successfully' do
      get assistant_session_path(assistant_session)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH update' do
    context 'with message' do
      before do
        allow(ChatResponseJob).to receive(:perform_later)
      end

      it 'enqueues the chat response job' do
        patch assistant_session_path(assistant_session),
              params: { assistant_session: { current_message: 'Hello' } },
              headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        expect(ChatResponseJob).to have_received(:perform_later).with(assistant_session.id, 'Hello')
      end

      it 'sets status to processing' do
        patch assistant_session_path(assistant_session),
              params: { assistant_session: { current_message: 'Hello' } },
              headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        assistant_session.reload
        expect(assistant_session.status).to eq('processing')
      end
    end

    context 'with reset_chat' do
      before do
        assistant_session.update!(log: [{ role: 'user', content: 'test' }])
      end

      it 'clears the chat log' do
        patch assistant_session_path(assistant_session),
              params: { reset_chat: 'reset' },
              headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        assistant_session.reload
        expect(assistant_session.log).to eq([])
      end
    end

    context 'with blank message' do
      it 'adds error message to log' do
        patch assistant_session_path(assistant_session),
              params: { assistant_session: { current_message: '' } },
              headers: { 'Accept' => 'text/vnd.turbo-stream.html' }

        assistant_session.reload
        expect(assistant_session.log.last['content']).to include('Message is missing')
      end
    end
  end
end
