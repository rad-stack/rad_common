class CreateSearchSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :search_settings do |t|
      t.references :user, foreign_key: true, null: false
      t.string :search_class, null: false
      t.string :columns, null: false, default: [], array: true

      t.timestamps

      t.index %i[user_id search_class], unique: true, name: 'unique_search_settings'
    end

    add_reference :saved_search_filters, :search_setting, foreign_key: true

    SavedSearchFilter.all.each do |filter|
      filter.update!(search_setting: SearchSetting.create!(user: filter.user, search_class: filter.search_class))
    end

    execute <<~SQL.squish
      UPDATE audits
      SET associated_type = 'SearchSetting',
        associated_id = (
          SELECT ss.id
          FROM search_settings ss
          INNER JOIN saved_search_filters ssf ON ss.user_id = audits.user_id
                                              AND ss.search_class = ssf.search_class
          WHERE ss.user_id = audits.user_id
          LIMIT 1
      )
      WHERE auditable_type = 'SavedSearchFilter' AND EXISTS (
        SELECT 1
        FROM saved_search_filters ssf
        INNER JOIN search_settings ss ON ss.user_id = audits.user_id
                                        AND ss.search_class = ssf.search_class
        WHERE ssf.id = audits.auditable_id
      );
    SQL

    remove_column :saved_search_filters, :search_class, :string
    remove_reference :saved_search_filters, :user
  end
end
