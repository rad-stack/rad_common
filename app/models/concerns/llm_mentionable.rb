module LLMMentionable
  extend ActiveSupport::Concern

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
    "@[#{self.class.name}:#{id}:#{self}]"
  end

  def mention_display
    "@#{self}"
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
