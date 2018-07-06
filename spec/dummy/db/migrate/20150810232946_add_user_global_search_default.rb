class AddUserGlobalSearchDefault < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :global_search_default, :string
  end
end
