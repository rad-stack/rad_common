module LLM
  module Tools
    class BaseCRNAUserDataTool < Base
      include RadHelper
      def call
        build_prompt
      end

      def formatting_details
        <<~USER_DATA
          The user data is represented by user ids, anywhere you put user id put it in this form ${USER_ID:1234} where 1234 is the id, so we can replace
        USER_DATA
      end

      private

        def data_extractor
          @data_extractor ||= UserDataExtractor.new(users, include_pref_data: true)
        end

        def data
          @data ||= data_extractor.extract
        end

        def users
          @users ||= User.where(id: user_id)
        end

        def user_id
          @context.contextable_id
        end

        def case_assignment_batch
          @context.chat_scope
        end

        def build_user_data_prompt
          raise NotImplementedError
        end

        def build_prompt
          "#{build_user_data_prompt} \n #{formatting_details}"
        end
    end
  end
end
