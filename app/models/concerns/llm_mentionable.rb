module LLMMentionable
  extend ActiveSupport::Concern

  included do
    scope :mentionable_search, ->(query) { where('LOWER(first_name) LIKE :q OR LOWER(last_name) LIKE :q', q: "%#{query.downcase}%") }
  end

  def to_llm_context
    {
      type: self.class.name,
      id: id,
      label: to_s,
      data: llm_attributes
    }
  end

  def llm_attributes
    { id: id, name: to_s }
  end

  def mention_token
    "@[#{self.class.name}:#{id}:#{to_s}]"
  end

  def mention_display
    "@#{to_s}"
  end

  class_methods do
    def mentionable_label
      model_name.human
    end

    def mentionable_icon
      'user'
    end
  end
end
