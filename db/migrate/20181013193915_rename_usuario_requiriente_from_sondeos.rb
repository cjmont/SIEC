class RenameUsuarioRequirienteFromSondeos < ActiveRecord::Migration
  def change
  	rename_column :sondeos, :usuario_requiriente, :empleado_solicitante
  end
end
