class CreateApiLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :api_logs do |t|
      t.string :service_name, null: false
      t.string :http_method, null: false
      t.string :url, null: false
      t.jsonb :request_headers
      t.jsonb :request_body
      t.integer :response_status
      t.jsonb :response_headers
      t.jsonb :response_body
      t.boolean :success, null: false, default: false
      t.string :error_message
      t.string :credential_key_name
      t.float :duration_ms
      t.datetime :created_at, null: false
    end

    add_index :api_logs, :service_name
    add_index :api_logs, :success
    add_index :api_logs, :created_at
  end
end
