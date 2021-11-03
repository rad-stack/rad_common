class FixArrayType < ActiveRecord::Migration[6.1]
  def change
    change_column_null :companies, :valid_user_domains, false

    # TODO: fix any other array types with null: false and default: []
  end
end
