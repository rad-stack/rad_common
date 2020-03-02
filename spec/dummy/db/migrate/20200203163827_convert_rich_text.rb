class ConvertRichText < ActiveRecord::Migration[6.0]
  def change
    # this is a sample migration for converting text to rich text
    # convert_rich_text 'order_notes', 'note', 'OrderNote'
  end

  private

  def convert_rich_text(table_name, field_name, model_name)
    execute "INSERT INTO action_text_rich_texts "\
                "(name, body, record_type, record_id, created_at, updated_at) "\
                "SELECT '#{field_name}' AS name, #{field_name}, '#{model_name}' AS record_type, id, updated_at, updated_at "\
                "FROM #{table_name} WHERE #{field_name} IS NOT NULL AND #{field_name} <> ''"

    remove_column table_name, field_name
  end
end
