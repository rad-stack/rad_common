class RefineSmarty < ActiveRecord::Migration[6.1]
  def change
    # run this for each model that has the Contactable concern
    fix_address_metadata 'companies', 'Company'
    fix_address_metadata 'attorneys', 'Attorney'
  end

  private

    def fix_address_metadata(table_name, model_name)
      add_column table_name, :address_metadata, :jsonb

      klass = model_name.constantize

      if klass.exists?
        klass.where.not(address_problems: nil).each do |item|
          item.update_column :address_metadata, { problems: item.address_problems_before_type_cast }
        end
      end

      remove_column table_name, :bypass_address_validation
      remove_column table_name, :address_problems
      remove_column table_name, :address_changes
    end
end
