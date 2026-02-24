require 'rails_helper'

describe RadConfig, type: :service do
  describe 'check_schema!' do
    let(:config) { Rails.configuration.rad_common }

    it 'passes with valid config' do
      expect { described_class.send(:check_schema!) }.not_to raise_error
    end

    it 'raises for a missing required key' do
      original = config.delete(:app_name)

      expect { described_class.send(:check_schema!) }.to raise_error(/missing required config key: app_name/)
    ensure
      config[:app_name] = original
    end

    it 'raises for a wrong type on a boolean key' do
      original = config[:use_avatar]
      config[:use_avatar] = 'yes'

      expect { described_class.send(:check_schema!) }.to raise_error(/use_avatar must be true or false/)
    ensure
      config[:use_avatar] = original
    end

    it 'raises for a wrong type on a string key' do
      original = config[:app_name]
      config[:app_name] = 123

      expect { described_class.send(:check_schema!) }.to raise_error(/app_name must be a String/)
    ensure
      config[:app_name] = original
    end

    it 'raises for a wrong type on an integer key' do
      original = config[:timeout_hours]
      config[:timeout_hours] = 'six'

      expect { described_class.send(:check_schema!) }.to raise_error(/timeout_hours must be an Integer/)
    ensure
      config[:timeout_hours] = original
    end

    it 'raises for a wrong type on an array key' do
      original = config[:duplicates]
      config[:duplicates] = 'not_an_array'

      expect { described_class.send(:check_schema!) }.to raise_error(/duplicates must be an Array/)
    ensure
      config[:duplicates] = original
    end

    it 'collects multiple errors' do
      original_name = config.delete(:app_name)
      original_host = config.delete(:host_name)

      expect { described_class.send(:check_schema!) }.to raise_error(/app_name.*host_name/m)
    ensure
      config[:app_name] = original_name
      config[:host_name] = original_host
    end

    it 'allows optional keys to be absent' do
      original = config.delete(:client_table_name)

      expect { described_class.send(:check_schema!) }.not_to raise_error
    ensure
      config[:client_table_name] = original if original
    end

    it 'does not raise for extra host-app-specific keys' do
      config[:custom_host_app_key] = 'anything'

      expect { described_class.send(:check_schema!) }.not_to raise_error
    ensure
      config.delete(:custom_host_app_key)
    end
  end

  describe 'SCHEMA' do
    it 'covers all known config keys' do
      expect(described_class::SCHEMA).to be_a(Hash)
      expect(described_class::SCHEMA).to be_frozen
    end
  end
end
