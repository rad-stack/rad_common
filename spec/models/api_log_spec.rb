require 'rails_helper'

RSpec.describe ApiLog do
  describe 'validations' do
    it 'requires service_name' do
      api_log = build(:api_log, service_name: nil)
      expect(api_log).not_to be_valid
    end

    it 'requires http_method' do
      api_log = build(:api_log, http_method: nil)
      expect(api_log).not_to be_valid
    end

    it 'requires url' do
      api_log = build(:api_log, url: nil)
      expect(api_log).not_to be_valid
    end

    it 'creates a valid api_log' do
      api_log = build(:api_log)
      expect(api_log).to be_valid
    end
  end

  describe '.sanitize_headers' do
    it 'filters authorization headers' do
      headers = { 'Authorization' => 'Bearer secret123', 'Content-Type' => 'application/json' }
      result = described_class.sanitize_headers(headers)

      expect(result['Authorization']).to eq('[FILTERED]')
      expect(result['Content-Type']).to eq('application/json')
    end

    it 'filters api key headers' do
      headers = { 'api-key' => 'my-secret', 'Accept' => 'application/json' }
      result = described_class.sanitize_headers(headers)

      expect(result['api-key']).to eq('[FILTERED]')
      expect(result['Accept']).to eq('application/json')
    end

    it 'filters token headers' do
      headers = { 'X-Api-Token' => 'secret', 'Accept' => 'application/json' }
      result = described_class.sanitize_headers(headers)

      expect(result['X-Api-Token']).to eq('[FILTERED]')
    end

    it 'filters password headers' do
      headers = { 'X-Password' => 'secret123' }
      result = described_class.sanitize_headers(headers)

      expect(result['X-Password']).to eq('[FILTERED]')
    end

    it 'handles nested hashes' do
      headers = { 'auth' => { 'token' => 'secret', 'type' => 'bearer' } }
      result = described_class.sanitize_headers(headers)

      expect(result['auth']['token']).to eq('[FILTERED]')
      expect(result['auth']['type']).to eq('bearer')
    end

    it 'returns nil for blank data' do
      expect(described_class.sanitize_headers(nil)).to be_nil
      expect(described_class.sanitize_headers({})).to be_nil
    end
  end

  describe '.truncate_body' do
    it 'returns nil for blank body' do
      expect(described_class.truncate_body(nil)).to be_nil
    end

    it 'returns hash as-is' do
      body = { 'key' => 'value' }
      expect(described_class.truncate_body(body)).to eq(body)
    end

    it 'parses valid JSON strings' do
      body = '{"key":"value"}'
      expect(described_class.truncate_body(body)).to eq({ 'key' => 'value' })
    end

    it 'truncates non-JSON strings' do
      body = 'x' * 20_000
      result = described_class.truncate_body(body)
      expect(result.length).to be <= 10_003 # 10000 chars + "..."
    end
  end

  describe '#to_s' do
    it 'returns a string representation' do
      api_log = build(:api_log, service_name: 'MyService', http_method: 'GET', response_status: 200)
      expect(api_log.to_s).to eq('MyService GET 200')
    end
  end

  describe '#table_row_style' do
    it 'returns table-danger for failed requests' do
      api_log = build(:api_log, :failed)
      expect(api_log.table_row_style).to eq('table-danger')
    end

    it 'returns nil for successful requests' do
      api_log = build(:api_log, success: true)
      expect(api_log.table_row_style).to be_nil
    end
  end
end
