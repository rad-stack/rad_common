module Pace
  class TopicQuestionResponseHandler < Base
    attr_accessor :id

    attr_accessor :active

    attr_accessor :tags

    attr_accessor :io_id

    attr_accessor :source_organization_company

    attr_accessor :template_line

    attr_accessor :sequence

    attr_accessor :translated_type

    attr_accessor :translated_value_attribute_type

    attr_accessor :translated_value

    attr_accessor :next_topic

    attr_accessor :bypass_remaining_topic_questions

    attr_accessor :response_type

    attr_accessor :stop_questionnaire

    attr_accessor :topic_question

    attr_accessor :response_value


    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'id' => :'id',
        :'active' => :'active',
        :'tags' => :'tags',
        :'io_id' => :'ioID',
        :'source_organization_company' => :'sourceOrganizationCompany',
        :'template_line' => :'templateLine',
        :'sequence' => :'sequence',
        :'translated_type' => :'translatedType',
        :'translated_value_attribute_type' => :'translatedValueAttributeType',
        :'translated_value' => :'translatedValue',
        :'next_topic' => :'nextTopic',
        :'bypass_remaining_topic_questions' => :'bypassRemainingTopicQuestions',
        :'response_type' => :'responseType',
        :'stop_questionnaire' => :'stopQuestionnaire',
        :'topic_question' => :'topicQuestion',
        :'response_value' => :'responseValue'
      }
    end
  end
end
