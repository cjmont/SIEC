class Nivel < ActiveRecord::Base
#BUSCAR EL NIVEL DE ACUERDO AL ID DE CONTENIDO
	def self.buscarNivel(id)
		where(contenido_id: id)
	end
end
