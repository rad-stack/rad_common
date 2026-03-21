module RadSearch
  class PhoneNumberFilter < LikeFilter
    def apply_filter(results, params)
      value = like_value(params)&.tr('^0-9', '')
      results = results.where(build_query, search: "%#{value}%") if value.present?
      results
    end

    private

      def column_transform(column)
        "REGEXP_REPLACE(#{column}, '[^0-9%]+', '', 'g')"
      end

      def build_query
        return "#{column_transform(column)} ilike :search" unless column.is_a?(Array)

        column.map { |c| "#{column_transform(c)} ilike :search" }.join(' OR ')
      end
  end
end
