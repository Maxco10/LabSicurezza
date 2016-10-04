class EditTipoLuogo < ActiveRecord::Migration
  def change
        change_column :announcements, :luogo, :text
  end
end
