class EnablePgStatStatements < ActiveRecord::Migration[7.2]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA heroku_ext'
  end

  def down
    execute 'DROP EXTENSION IF EXISTS pg_stat_statements'
  end
end
