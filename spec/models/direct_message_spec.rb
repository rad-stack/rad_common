require 'rails_helper'

RSpec.describe DirectMessage do
  let(:sender) { create :user }
  let(:recipient) { create :user }
  let(:direct_message) { create :direct_message, sender: sender, recipient: recipient }

  describe 'validations' do
    it 'requires sender and recipient to be different' do
      dm = build(:direct_message, sender: sender, recipient: sender)
      expect(dm).not_to be_valid
      expect(dm.errors[:recipient]).to include("can't be the same as sender")
    end

    it 'enforces uniqueness of sender/recipient pair' do
      direct_message
      duplicate = build(:direct_message, sender: sender, recipient: recipient)
      expect(duplicate).not_to be_valid
    end
  end

  describe '.find_or_create_conversation' do
    it 'creates a new conversation when none exists' do
      dm = described_class.find_or_create_conversation(sender, recipient)
      expect(dm).to be_persisted
      expect(dm.sender).to eq(sender)
      expect(dm.recipient).to eq(recipient)
    end

    it 'finds existing conversation regardless of user order' do
      direct_message
      dm = described_class.find_or_create_conversation(recipient, sender)
      expect(dm).to eq(direct_message)
    end
  end

  describe '#other_user' do
    it 'returns recipient when given sender' do
      expect(direct_message.other_user(sender)).to eq(recipient)
    end

    it 'returns sender when given recipient' do
      expect(direct_message.other_user(recipient)).to eq(sender)
    end
  end

  describe '#participant?' do
    it 'returns true for sender' do
      expect(direct_message.participant?(sender)).to be true
    end

    it 'returns true for recipient' do
      expect(direct_message.participant?(recipient)).to be true
    end

    it 'returns false for other users' do
      other = create(:user)
      expect(direct_message.participant?(other)).to be false
    end
  end

  describe '#handle_chat_message' do
    it 'adds message to log' do
      direct_message.handle_chat_message('Hello!', sender)
      expect(direct_message.reload.log.length).to eq(1)
      expect(direct_message.log.last['content']).to eq('Hello!')
      expect(direct_message.log.last['user_id']).to eq(sender.id)
    end

    it 'handles nil message' do
      direct_message.handle_chat_message(nil, sender)
      expect(direct_message.reload.log.length).to eq(1)
      expect(direct_message.log.last['role']).to eq('assistant')
      expect(direct_message.log.last['content']).to include('missing')
    end
  end

  describe '#chat_processing?' do
    it 'returns false' do
      expect(direct_message.chat_processing?).to be false
    end
  end

  describe '#reset_chat!' do
    it 'clears the log' do
      direct_message.handle_chat_message('Hello!', sender)
      direct_message.reset_chat!
      expect(direct_message.reload.log).to eq([])
    end
  end

  describe '#to_s' do
    it 'returns conversation description' do
      expect(direct_message.to_s).to include('Conversation between')
    end
  end
end
