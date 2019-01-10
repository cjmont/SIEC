class AddAccionToPermisoAccion < ActiveRecord::Migration
  def change
    add_reference :permisos_acciones, :accion, index: true, foreign_key: true
  end
end
