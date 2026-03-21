class AddApiKeyToDivisions < ActiveRecord::Migration[7.2]
  def change
    add_column :divisions, :api_key, :string
  end
end
