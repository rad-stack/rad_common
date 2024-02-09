class AuditsUsersFk < ActiveRecord::Migration[7.0]
  def change
    return if foreign_key_exists?(:audits, :users)

    add_foreign_key :audits, :users
  end
end
