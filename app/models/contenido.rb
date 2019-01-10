class Contenido < ActiveRecord::Base
	
	def self.buscarContenido(id)
		find_by(prospecto_id: id)
	end
end
