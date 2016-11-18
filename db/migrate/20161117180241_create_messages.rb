class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :titolo
      t.string :testo
      t.references :mittente, index: true, foreign_key: true
      t.references :destinatario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
