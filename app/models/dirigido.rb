class Dirigido < ActiveRecord::Base
#BUSCAR DIRIGIDO DE ACUERDO AL ID DE CONTENIDO
	def self.buscarDirigido(id)
		where(contenido_id: id)
	end
end
