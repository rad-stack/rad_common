require 'rails_helper'

RSpec.describe LLM::MentionParser do
  let(:user) { create :user }

  describe '#parse' do
    context 'with valid mentions' do
      let(:message) { "Hello @[User:#{user.id}:#{user}], how are you?" }
      let(:parser) { described_class.new(message) }

      it 'extracts mention data' do
        mentions = parser.parse

        expect(mentions.length).to eq(1)
        expect(mentions.first[:type]).to eq('User')
        expect(mentions.first[:id]).to eq(user.id)
        expect(mentions.first[:label]).to eq(user.to_s)
      end
    end

    context 'with multiple mentions' do
      let(:other_user) { create :user }
      let(:message) { "@[User:#{user.id}:#{user}] and @[User:#{other_user.id}:#{other_user}]" }
      let(:parser) { described_class.new(message) }

      it 'extracts all mentions' do
        mentions = parser.parse

        expect(mentions.length).to eq(2)
        expect(mentions.pluck(:id)).to contain_exactly(user.id, other_user.id)
      end
    end

    context 'with no mentions' do
      let(:message) { 'Hello, how are you?' }
      let(:parser) { described_class.new(message) }

      it 'returns empty array' do
        expect(parser.parse).to eq([])
      end
    end

    context 'with malformed mentions' do
      let(:message) { 'Hello @[Invalid format] and @regular' }
      let(:parser) { described_class.new(message) }

      it 'ignores malformed mentions' do
        expect(parser.parse).to eq([])
      end
    end
  end

  describe '#mentions?' do
    it 'returns true when mentions exist' do
      parser = described_class.new("@[User:#{user.id}:#{user}]")
      expect(parser.mentions?).to be true
    end

    it 'returns false when no mentions' do
      parser = described_class.new('No mentions here')
      expect(parser.mentions?).to be false
    end
  end

  describe '#expand_mentions' do
    let(:message) { "@[User:#{user.id}:#{user}]" }
    let(:parser) { described_class.new(message) }

    it 'returns LLM context for valid mentions' do
      contexts = parser.expand_mentions

      expect(contexts.length).to eq(1)
      expect(contexts.first[:type]).to eq('User')
      expect(contexts.first[:id]).to eq(user.id)
      expect(contexts.first[:data]).to be_present
    end

    context 'with non-existent record' do
      let(:message) { '@[User:999999:Ghost User]' }

      it 'skips missing records' do
        expect(parser.expand_mentions).to eq([])
      end
    end

    context 'with non-mentionable type' do
      let(:message) { '@[InvalidClass:1:Test]' }

      it 'skips invalid types' do
        expect(parser.expand_mentions).to eq([])
      end
    end
  end

  describe '#build_context_string' do
    let(:message) { "@[User:#{user.id}:#{user}]" }
    let(:parser) { described_class.new(message) }

    it 'builds formatted context string' do
      context_string = parser.build_context_string

      expect(context_string).to include('User')
      expect(context_string).to include("ID: #{user.id}")
    end

    context 'with no mentions' do
      let(:message) { 'No mentions' }

      it 'returns nil' do
        expect(parser.build_context_string).to be_nil
      end
    end
  end

  describe '#message_for_display' do
    let(:message) { "Hello @[User:#{user.id}:John Smith], how are you?" }
    let(:parser) { described_class.new(message) }

    it 'converts tokens to display format' do
      display = parser.message_for_display

      expect(display).to eq('Hello @John Smith, how are you?')
      expect(display).not_to include('[User:')
    end

    context 'with no mentions' do
      let(:message) { 'Plain message' }

      it 'returns original message' do
        expect(parser.message_for_display).to eq(message)
      end
    end
  end
end
