class Api::SondeopostController < ApplicationController

skip_before_filter :verify_authenticity_token, if: :json_request?

  def json_request?
    request.format.json?
  end
		def cors_set_access_control_headers
	        headers['Access-Control-Allow-Origin'] = '*'
	        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, PATCH, OPTIONS'
	        headers['Access-Control-Request-Method'] = '*'
	        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	    end
	def index
		@sondeo = Sondeo.new
        @sondeo = Sondeo.all
        render json: @sondeo
    end
 
	def create
		@sondeo = Sondeo.new(sondeo_params)
	    if @sondeo.save
	    	render :status => "200", :json => {:message => "Enviado"}.to_json
	    else
           render :status => "400", :json => {:status => "No se envio"}.to_json
		end
	end

private
	def sondeo_params
		params.require(:sondeopost).permit(:estado, :empleado_solicitante, :prospecto_id)
	end
end