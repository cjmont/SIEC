class AddPermisoToPermisoAccion < ActiveRecord::Migration
  def change
    add_reference :permisos_acciones, :permiso, index: true, foreign_key: true
  end
end
