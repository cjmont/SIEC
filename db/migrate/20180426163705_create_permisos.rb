class CreatePermisos < ActiveRecord::Migration
  def change
    create_table :permisos do |t|
      t.string :sistema

      t.timestamps null: false
    end
  end
end
