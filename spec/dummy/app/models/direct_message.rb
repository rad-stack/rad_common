class DirectMessage < ApplicationRecord
  audited

  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  attr_accessor :current_message

  scope :sorted, -> { order(updated_at: :desc) }

  validates :from_user, presence: true
  validates :to_user, presence: true

  def self.find_or_create_conversation(user_a, user_b)
    find_by(from_user: user_a, to_user: user_b) ||
      find_by(from_user: user_b, to_user: user_a) ||
      create!(from_user: user_a, to_user: user_b)
  end

  def other_user(current_user)
    current_user == from_user ? to_user : from_user
  end

  def to_s
    "Conversation between #{from_user} and #{to_user}"
  end
end
