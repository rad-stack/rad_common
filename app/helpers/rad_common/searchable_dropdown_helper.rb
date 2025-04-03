module RadCommon
  MAX_DROPDOWN_SIZE = 300
  module SearchableDropdownHelper
    def searchable_scope_options(search_scope:, show_subtext: false, excluded_ids: nil)
      {
        class: 'selectpicker-search',
        'data-subtext' => show_subtext,
        'data-global-search-scope' => search_scope,
        'data-global-search-mode' => 'searchable_association',
        'data-excluded-ids' => excluded_ids
      }
    end

    def max_dropdown_size_exceeded?(records)
      records.size > MAX_DROPDOWN_SIZE
    end
  end
end
