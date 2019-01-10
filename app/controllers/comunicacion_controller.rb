class ComunicacionController < ApplicationController
  def index
  end

  def nombreProspecto
  	nombre = Prospecto.find_by(id: params[:id])
  end
end
