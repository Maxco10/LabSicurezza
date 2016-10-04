class AddLaitudineAndLongitudineToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :latitudine, :float
    add_column :announcements, :longitudine, :float
    rename_column :announcements, :id_luogo_id, :luogo
  end
end
