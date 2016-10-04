class FixAttributiPerLuogo < ActiveRecord::Migration
  def change
    rename_column :announcements, :latitudine, :latitude
    rename_column :announcements, :longitudine, :longitude
  end
end
