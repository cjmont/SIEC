class CreatePermisosAcciones < ActiveRecord::Migration
  def change
    create_table :permisos_acciones do |t|

      t.timestamps null: false
    end
  end
end
