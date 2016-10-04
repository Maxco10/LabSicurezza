class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :titolo
      t.text :descrizione
      t.string :categoria
      t.string :foto
      t.integer :etichetta, default: 0, null: false
      t.integer :segnalato, default: 0
      t.integer :visite, default: 0
      t.references :id_proprietario, null: false
      t.references :id_luogo
      
      t.timestamps null: false
    end
  end
end
