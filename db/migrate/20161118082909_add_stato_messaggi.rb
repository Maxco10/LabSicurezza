class AddStatoMessaggi < ActiveRecord::Migration
  def change
    add_column :messages, :stato, :integer
  end
end
