class AddRolToEmpleado < ActiveRecord::Migration
  def change
    add_reference :empleados, :rol, index: true, foreign_key: true
  end
end
