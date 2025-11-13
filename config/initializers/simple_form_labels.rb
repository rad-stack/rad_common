# Monkey patch SimpleForm to use titleize instead of humanize for labels - Task 11544

module SimpleForm
  module Components
    module Labels
      protected

        def label_translation
          if SimpleForm.translate_labels && (translated_label = translate_from_namespace(:labels))
            translated_label
          elsif object.class.respond_to?(:model_name) && (ar_translation = I18n.t(
            "activerecord.attributes.#{object.class.model_name.i18n_key}.#{reflection_or_attribute_name}", default: nil
          ))
            ar_translation
          elsif object.class.respond_to?(:human_attribute_name)
            object.class.human_attribute_name(reflection_or_attribute_name.to_s, { base: object }).titleize
          else
            attribute_name.to_s.titleize
          end
        end
    end
  end
end
