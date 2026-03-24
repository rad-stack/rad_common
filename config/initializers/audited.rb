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
      attributes.tap do |items|
        if items.include? 'body'
          items['body'] =
            if items['body'].is_a? Array
              items['body'].collect(&:to_s)
            else
              items['body'].to_s
            end
        end
      end
    end
end

ActiveSupport.on_load(:action_text_rich_text) do
  ActiveSupport.on_load(:action_text_rich_text) { prepend ActionTextRichTextAuditing }
end
