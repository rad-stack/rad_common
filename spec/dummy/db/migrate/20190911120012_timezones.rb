class Timezones < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :timezone, :string

    timezone = 'Eastern Time (US & Canada)'
    # timezone = 'Mountain Time (US & Canada)'
    # timezone = 'Pacific Time (US & Canada)'

    execute "UPDATE companies SET timezone = '#{timezone}' WHERE timezone IS NULL OR timezone = ''"
    change_column_null :companies, :timezone, false

    execute "UPDATE users SET timezone = '#{timezone}' WHERE timezone IS NULL OR timezone = ''"
    change_column_null :users, :timezone, false
  end
end
