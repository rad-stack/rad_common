require 'rails_helper'

RSpec.describe LLMMentionable do
  let(:user) { create(:user) }

  describe '#to_llm_context' do
    it 'returns context hash with required keys' do
      context = user.to_llm_context

      expect(context[:type]).to eq('User')
      expect(context[:id]).to eq(user.id)
      expect(context[:label]).to eq(user.to_s)
      expect(context[:data]).to be_a(Hash)
    end
  end

  describe '#llm_attributes' do
    it 'returns hash with id and name' do
      attrs = user.llm_attributes

      expect(attrs[:id]).to eq(user.id)
      expect(attrs[:name]).to eq(user.to_s)
    end
  end

  describe '#mention_token' do
    it 'returns properly formatted token' do
      token = user.mention_token

      expect(token).to eq("@[User:#{user.id}:#{user}]")
      expect(token).to match(LLM::MentionParser::MENTION_PATTERN)
    end
  end

  describe '#mention_display' do
    it 'returns @ prefixed name' do
      expect(user.mention_display).to eq("@#{user}")
    end
  end

  describe '.mentionable_search' do
    let!(:john) { create(:user, first_name: 'John', last_name: 'Smith') }
    let!(:jane) { create(:user, first_name: 'Jane', last_name: 'Doe') }
    let!(:bob) { create(:user, first_name: 'Bob', last_name: 'Williams') }

    it 'finds users by first name' do
      results = User.mentionable_search('john')

      expect(results).to include(john)
      expect(results).not_to include(jane, bob)
    end

    it 'finds users by last name' do
      results = User.mentionable_search('doe')

      expect(results).to include(jane)
      expect(results).not_to include(john, bob)
    end

    it 'is case insensitive' do
      results = User.mentionable_search('JOHN')

      expect(results).to include(john)
    end

    it 'finds partial matches' do
      results = User.mentionable_search('smith')

      expect(results).to include(john)
    end

    it 'returns empty when no match' do
      results = User.mentionable_search('xyz')

      expect(results).to be_empty
    end
  end

  describe '.mentionable_label' do
    it 'returns humanized model name' do
      expect(User.mentionable_label).to eq('User')
    end
  end

  describe '.mentionable_icon' do
    it 'returns default icon' do
      expect(User.mentionable_icon).to eq('user')
    end
  end
end
