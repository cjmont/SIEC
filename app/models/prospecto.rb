class Prospecto < ActiveRecord::Base
  belongs_to :estado
  belongs_to :area
  belongs_to :prospecto

  has_many :contenido

	#busqueda de estado
	def self.buscarEstado(id)
		find_by(estado_id: id)
	end
#buscar toda la lista de prospecto con respecto a su estado
	def self.buscarProspectoPorEstado(id)
		where(estado_id: id)
	end
#BUSCAR PROSPECTOS POR SU ID
	def self.buscarProspectoPorId(id)
		find_by(id: id)
	end
	def self.buscarTipoProspecto(tipo)
		where("tipo = ?" ,tipo)
	end
	def self.buscarProspectoNombre(nombre)
		where(nombre: nombre)
	end
	
end
