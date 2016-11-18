class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :voto
      t.references :proprietario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
