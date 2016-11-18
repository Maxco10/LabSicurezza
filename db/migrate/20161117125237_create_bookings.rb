class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :annuncio, index: true, foreign_key: true
      t.references :proprietario, index: true, foreign_key: true
      t.references :prenotato, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
