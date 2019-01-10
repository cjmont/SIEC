class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :usuario_id
      t.integer :sondeo_id
      t.references :usuario, index: true, foreign_key: true
      t.references :sondeo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
