module AttorneysHelper
  def attorney_actions(attorney)
    [fix_duplicates_attorney_action(attorney)]
  end

  def fix_duplicates_attorney_action(attorney)
    return unless attorney.duplicate_score && policy(Attorney).show?

    link_to(icon(:cubes, 'Fix Duplicates'),
            show_current_duplicates_attorneys_path(attorney_id: attorney.id),
            class: 'btn btn-info btn-sm')
  end

  def attorney_show_data
    %i[company_name address_1 address_2 city state zipcode phone_number email]
  end
end
