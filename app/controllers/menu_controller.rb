class MenuController < ApplicationController

	def index
		if verificarUsuario then
			 redirect_to root_url
		end
	end

	private

	def verificarUsuario
		user = session[:nombre]
		pass = session[:clave]
		if Usuarioacademico.getUsuario(user,pass)
			return true
		else
			return false 
		end
	end
end
