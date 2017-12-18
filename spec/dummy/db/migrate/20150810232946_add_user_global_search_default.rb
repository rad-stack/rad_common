class AddUserGlobalSearchDefault < ActiveRecord::Migration
  def change
    add_column :users, :global_search_default, :string
  end
end
