class CreateSondeos < ActiveRecord::Migration
  def change
    create_table :sondeos do |t|
      t.string :estado
      t.integer :usuario_requiriente
      t.integer :prospecto_id
      t.references :prospecto, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
