class SesionController < ApplicationController
	def index
		user = session[:nombre]
		pass = session[:clave]
		if Usuarioacademico.getUsuario(user,pass)
		   redirect_to :controller => 'menu', :action => 'index'
		else
			return false 
		end
		
	end

	def cerrarSesion

	end

	private

	def verificarSesion
	end
end
