class FixBooleanNullsDefaults < ActiveRecord::Migration[7.0]
  def change
    change_column_null :login_activities, :success, false
    change_column_default :login_activities, :success, false
  end
end
