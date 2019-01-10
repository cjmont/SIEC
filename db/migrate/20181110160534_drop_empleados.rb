class DropEmpleados < ActiveRecord::Migration
  def change
  	drop_table :empleados
  end
end
