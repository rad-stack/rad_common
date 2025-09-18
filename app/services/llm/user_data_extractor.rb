module LLM
  class UserDataExtractor
    include RadHelper
    def initialize(users, include_pref_data: false, include_shift_data: false, include_mallow_data: false)
      @users = users
      @include_pref_data = include_pref_data
      @include_shift_data = include_shift_data
      @include_mallow_data = include_mallow_data
    end

    def extract
      @users.filter_map do |user|
        last_time_entry = user.time_entries.sorted.first
        if last_time_entry
          data = { id: user.id }
          if @include_shift_data
            shift_date = last_time_entry.shift_date
            shift_star_time, shift_end_time = shift_default_start_end(last_time_entry.shift, shift_date)
            data[:last_shift_start_time] = format_datetime(shift_star_time)
            data[:last_shift_end_time] = format_datetime(shift_end_time)
          end
          data[:mallow_score] = user.mallow_score.to_f if @include_mallow_data
          data[:preferences] = preference_data[user.id] if @include_pref_data
          data
        end
      end
    end

    private

      def preference_data
        # TODO: not sure I'm grabbing this right
        return @preference_data if @preference_data

        @preference_data = {}
        preference_inventories.each do |user_id, inventory|
          preferences = inventory.case_preferences.filter_map do |preference|
            if preference.rating.positive?
              { specialty_id: preference.specialty_id, rating: preference.rating,
                specialty_name: preference.specialty.name }
            end
          end
          preference_data[user_id] = preferences
        end
        @preference_data
      end

      def shift_default_start_end(shift, date)
        start_time = Time.zone.parse("#{date} #{shift.default_start_time}")
        end_time = start_time + shift.hours.hours
        [start_time, end_time]
      end

      def preference_inventories
        @preference_inventories ||= CasePreferenceInventory
                                    .includes(case_preferences: %i[specialty case_type_example])
                                    .where(user_id: @users.pluck(:id))
                                    .submitted
                                    .select('DISTINCT ON (user_id) *')
                                    .order('user_id, created_at DESC')
                                    .index_by(&:user_id)
      end
  end
end
