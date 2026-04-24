class CreateHerokuExtSchema < ActiveRecord::Migration[7.2]
  def up
    execute 'CREATE SCHEMA IF NOT EXISTS heroku_ext'
  end

  def down
    execute 'DROP SCHEMA IF EXISTS heroku_ext CASCADE'
  end
end
