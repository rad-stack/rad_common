require 'rails_helper'

RSpec.describe RadCommon::Utf8QueryGuard do
  subject(:middleware) { described_class.new(app) }

  let(:app) { ->(_env) { [200, { 'content-type' => 'text/plain' }, ['OK']] } }
  let(:invalid_query) { 'foo=%C0%AF' }
  let(:valid_query) { 'foo=bar' }

  def env_for(query_string, warden_user: nil)
    warden = warden_user.nil? ? nil : instance_double(Warden::Proxy, user: warden_user)
    { 'QUERY_STRING' => query_string, 'warden' => warden }
  end

  describe '#call' do
    context 'with a valid UTF-8 query string' do
      it 'passes the request through' do
        status, _headers, body = middleware.call(env_for(valid_query))
        expect(status).to eq 200
        expect(body).to eq ['OK']
      end
    end

    context 'with an empty query string' do
      it 'passes the request through' do
        status, = middleware.call(env_for(''))
        expect(status).to eq 200
      end
    end

    context 'with a nil query string' do
      it 'passes the request through' do
        status, = middleware.call(env_for(nil))
        expect(status).to eq 200
      end
    end

    context 'with invalid UTF-8 in the query string' do
      context 'when the user is not signed in' do
        it 'returns 400 Bad Request' do
          status, headers, body = middleware.call(env_for(invalid_query))
          expect(status).to eq 400
          expect(headers['content-type']).to eq 'text/plain'
          expect(body).to eq ['Bad Request']
        end

        it 'does not raise an exception' do
          expect { middleware.call(env_for(invalid_query)) }.not_to raise_error
        end

        it 'does not invoke the downstream app' do
          expect(app).not_to receive(:call)
          middleware.call(env_for(invalid_query))
        end
      end

      context 'when the user is signed in' do
        let(:user) { instance_double(User, id: 1) }

        it 'raises InvalidUtf8Query to trigger Sentry' do
          expect { middleware.call(env_for(invalid_query, warden_user: user)) }
            .to raise_error(described_class::InvalidUtf8Query, /Invalid UTF-8 in query string/)
        end
      end
    end
  end
end
