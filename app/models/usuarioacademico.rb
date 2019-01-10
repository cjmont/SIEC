class Usuarioacademico < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :rol
  def self.getUsuario(nombre,clave)
		where(nombre: nombre , clave: clave).exists?
	end
end
