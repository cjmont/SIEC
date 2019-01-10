class Empleado < ActiveRecord::Base
	def self.getEmpleado(nombre,pass)
		where(usuario: email , contrasenia: clave).exists?
	end
end
