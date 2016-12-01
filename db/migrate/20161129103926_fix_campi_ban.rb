class FixCampiBan < ActiveRecord::Migration
  def change
    change_column_default :users, :ban, 0
  end
end
