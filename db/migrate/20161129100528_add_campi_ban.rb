class AddCampiBan < ActiveRecord::Migration
  def change
    add_column :users, :ban, :integer
    add_column :users, :motivo_ban, :string
  end
end
