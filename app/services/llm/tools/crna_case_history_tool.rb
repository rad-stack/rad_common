module LLM
  module Tools
    class CRNACaseHistoryTool < BaseCRNAUserDataTool
      TOOL_DESCRIPTION = <<~EXAMPLES.freeze
        This tool is designed to provide the CRNA user recent case history.
        This tool lists recent cases worked by the user, including the case type, room, start, and end times.
      EXAMPLES

      def description
        TOOL_DESCRIPTION
      end

      private

        def data_extractor
          @data_extractor ||= UserDataExtractor.new(users, include_pref_data: true)
        end

        def presenter
          @presenter ||= CaseAssignmentBatchPresenter.new(case_assignment_batch)
        end

        def user_case_data
          recent_cases.map do |case_record|
            { room: case_record.room, start_time: case_record.start_time, end_time: case_record.end_time,
              case_type: case_record.case_type }
          end
        end

        def recent_cases
          Case.occurs_between(45.days.ago, Date.current).with_user(user_id).distinct.order(:start_time)
        end

        def average_effective_rating(cases, inventory)
          valid_case_ratings = cases.map { |case_record| case_record.case_type.effective_rating(inventory) }.compact
          return if valid_case_ratings.empty?

          valid_case_ratings.sum / valid_case_ratings.size
        end

        def build_user_data_prompt
          <<~USER_DATA
            Below is the user data of CRNAs for user with id #{user_id}
            #{user_case_data.to_json}
          USER_DATA
        end
    end
  end
end
