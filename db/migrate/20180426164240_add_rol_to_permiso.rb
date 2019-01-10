class AddRolToPermiso < ActiveRecord::Migration
  def change
    add_reference :permisos, :rol, index: true, foreign_key: true
  end
end
