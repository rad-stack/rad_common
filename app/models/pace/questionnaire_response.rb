module Pace
  class QuestionnaireResponse < Base
    attr_accessor :id

    attr_accessor :attribute

    attr_accessor :source

    attr_accessor :attribute_type

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :translated_value

    attr_accessor :topic_question

    attr_accessor :response_value

    attr_accessor :questionnaire_part

    attr_accessor :question_type_data_object

    attr_accessor :questionnaire_topic

    attr_accessor :parent_questionnaire_response


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'attribute' => :'attribute',
        :'source' => :'source',
        :'attribute_type' => :'attributeType',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'translated_value' => :'translatedValue',
        :'topic_question' => :'topicQuestion',
        :'response_value' => :'responseValue',
        :'questionnaire_part' => :'questionnairePart',
        :'question_type_data_object' => :'questionTypeDataObject',
        :'questionnaire_topic' => :'questionnaireTopic',
        :'parent_questionnaire_response' => :'parentQuestionnaireResponse'
      }
    end
  end
end
