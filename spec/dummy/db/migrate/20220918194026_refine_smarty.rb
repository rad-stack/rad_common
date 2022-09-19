class RefineSmarty < ActiveRecord::Migration[6.1]
  def change
    # run this for each model that has the Contactable concern
    fix_address_metadata 'companies'
    fix_address_metadata 'attorneys'
  end

  private

    def fix_address_metadata(table_name)
      add_column table_name, :address_metadata, :jsonb

      remove_column table_name, :bypass_address_validation
      remove_column table_name, :address_problems
      remove_column table_name, :address_changes
    end
end
