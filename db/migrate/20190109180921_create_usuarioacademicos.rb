class CreateUsuarioacademicos < ActiveRecord::Migration
  def change
    create_table :usuarioacademicos do |t|
      t.string :email
      t.string :clave
      t.references :rol, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
