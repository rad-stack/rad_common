# Create audits for action text rich text changes
# https://github.com/collectiveidea/audited/issues/547#issuecomment-2045234025
module ActionTextRichTextAuditing
  extend ActiveSupport::Concern

  prepended do
    audited
  end

  def audited_attributes(...)
    _stringify_body_attribute super
  end

  private

    def audited_changes(...)
      _stringify_body_attribute super
    end

    def _stringify_body_attribute(attributes)
      attributes.tap do |attributes|
        if attributes.include? 'body'
          attributes['body'] =
            if attributes['body'].is_a? Array
              attributes['body'].collect &:to_s
            else
              attributes['body'].to_s
            end
        end
      end
    end
end

ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.prepend ActionTextRichTextAuditing
end
