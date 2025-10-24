class CreateCustomReports < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_reports do |t|
      t.string :name, null: false
      t.text :description
      t.string :report_model, null: false
      t.jsonb :configuration, null: false, default: {}

      t.timestamps

      t.index :report_model
      t.index :name, unique: true
    end
  end
end
