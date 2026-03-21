class IndexDivisionsOnCreatedAt < ActiveRecord::Migration[7.2]
  def change
    add_index :divisions, :created_at
  end
end
