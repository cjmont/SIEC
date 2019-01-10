class AcademicoController < ApplicationController
	
	def academico
		
	end


	def sondeo
		@area = Area.all
	end


	def prospecto

		_num = 1 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@area = Area.all
		@tipos = params[:tipo]
		curso = 'academico' 
		ids = params[:ids]
		@atras = regresar(_num,curso,@tipos,ids)
		if @tipos == "crear"
		elsif @tipos == "editar"
			if Prospecto.exists?(ids)
				@prospectos = Prospecto.find_by(id: ids) 
			else
				@tipos = "crear"
			end
		else
			return redirect_to("/academico")
		end
		authorize! :read, @area
	end


	def createProspecto
		prospecto = Prospecto.new
		prospecto.nombre = params["nombre"]
		prospecto.linea_negocio = params["linea_negocio"]
		prospecto.tipo = params["tipo"]
		prospecto.area_id = params["area"]
		prospecto.estado_id = 7 #Estado =>En edicion
		if prospecto.save()
			if params["salir"] == "salir"
				return redirect_to("/academico")
			elsif params["salir"] == "guardar"
				redirect_to :controller => 'academico', :action => 'prospecto',:tipo => "editar", :ids => prospecto.id
			else 
				redirect_to :controller => 'academico', :action => 'contenido',:curso => params["tipo"],:tipo => "crear", :ids => prospecto.id
			end
		end
		authorize! :read, prospecto
	end


	def editProspecto
		_prospectos = Prospecto.find_by(id: params["id"])
		_prospectos.nombre =  params["nombre"]
		_prospectos.linea_negocio = params["linea_negocio"]
		_prospectos.tipo = params["tipo"]
		_prospectos.area_id = params["area"]
		if _prospectos.estado_id == 9 #estado Inactivo
			_prospectos.estado_id = 7 #estado en edicion
			if Contenido.exists?(prospecto_id: params["id"])
				_contenido = Contenido.where(prospecto_id: params["id"]).order(version: :asc).last
				_contenido.estado_id = 7
				_contenido.save()
			end
		end
		if _prospectos.save()
			
			if params["salir"] == "salir"
				return redirect_to("/academico")
			elsif params["salir"] == "guardar"

				  redirect_to :controller => 'academico', :action => 'prospecto',:tipo => "editar", :ids => params["id"]
			else
				redirect_to :controller => 'academico', :action => 'contenido',:curso => params["tipo"],:tipo => "editar", :ids => _prospectos.id
			end
		end
	end


	def contenido
		_num = 2 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@tipos = params[:tipo]
		@curso = params[:curso]
		if Prospecto.exists?(params[:ids])
			@prospectID = params[:ids]
			_prospecto = Prospecto.find_by(id:@prospectID)
			if _prospecto.estado_id == 7 #estado edicion
				if @tipos == "crear"
					@atras = regresar(_num,@curso,"editar",params[:ids])
				elsif @tipos == "editar"
					@atras = regresar(_num,@curso,@tipos,params[:ids])
					if Contenido.exists?(:prospecto_id => @prospectID)
						@contenido = Contenido.find_by(prospecto_id: @prospectID,estado_id: 7)
						if @contenido == nil
							@tipos = "crear"
						end
					else
						@tipos = "crear"
					end
				else
					return redirect_to("/academico")
				end
			elsif _prospecto.estado_id == 2 #estado publicado
				if Contenido.exists?(prospecto_id: @prospectID,estado_id: 2)
					if Contenido.exists?(prospecto_id: @prospectID,estado_id: 7)
						@contenido = Contenido.find_by(prospecto_id: @prospectID,estado_id: 7)
						@tipos = "editar"
						@atras = regresar(_num,@curso,"editar",params[:ids])
					else
						@contenido = nil
						@tipos = "crear"
						@atras = regresar(_num,@curso,"editar",params[:ids])
					end
				elsif Contenido.exists?(prospecto_id: @prospectID,estado_id: 7)
					@contenido = Contenido.find_by(prospecto_id: @prospectID,estado_id: 7)
					@tipos = "editar"
					@atras = regresar(_num,@curso,@tipos,params[:ids])
				else
					@tipos = "crear"
					@atras = regresar(_num,@curso,"editar",params[:ids])
					@contenido = nil
				end
			else	
				@tipos = "crear"
				@atras = regresar(_num,@curso,"editar",params[:ids])
				@contenido = nil
			end
		else
			return redirect_to :controller => 'academico', :action => 'prospecto',:tipo => "crear"
		end
	end


	def createContenido
		if Contenido.exists?(prospecto_id:params["idPros"])
			_contenido = Contenido.where(prospecto_id:params["idPros"]).order(version: :asc).last
			contenidos = Contenido.new
			contenidos.prospecto_id = params["idPros"]
			contenidos.modalidad = params["modalidad"]
			contenidos.certificado = params["certificado"]
			contenidos.objetivo = params["objetivo"]
			contenidos.objetivo_especifico = params["objetivoEsp"]
			contenidos.justificacion = params["justificacion"]
			contenidos.metodologia = params["metodologia"]
			contenidos.descripcion = params["descripcion"]
			contenidos.horas_presenciales = params["presenciales"]
			contenidos.horas_virtuales = params["virtuales"]
			contenidos.horas_autonomas = params["autonomas"]
			contenidos.version = _contenido.version + 1
			contenidos.estado_id = 7 #Estado =>En edicion
		else
			contenidos = Contenido.new
			contenidos.prospecto_id = params["idPros"]
			contenidos.modalidad = params["modalidad"]
			contenidos.certificado = params["certificado"]
			contenidos.objetivo = params["objetivo"]
			contenidos.objetivo_especifico = params["objetivoEsp"]
			contenidos.justificacion = params["justificacion"]
			contenidos.metodologia = params["metodologia"]
			contenidos.descripcion = params["descripcion"]
			contenidos.horas_presenciales = params["presenciales"]
			contenidos.horas_virtuales = params["virtuales"]
			contenidos.horas_autonomas = params["autonomas"]
			contenidos.version = 1
			contenidos.estado_id = 7 #Estado =>En edicion
		end
		if contenidos.save()
			if params["salir"] == "salir"
				return redirect_to("/academico")
			elsif params["salir"] == "guardar"
				redirect_to :controller => 'academico', :action => 'contenido',:curso => params["cursos"],:tipo => "editar", :ids => contenidos.prospecto_id
			else
				redirect_to :controller => 'academico', :action => 'perfilDocente',:curso => params["cursos"],:tipo => "crear", :ids => contenidos.id
			end
		end
	end


	def editarContenido
		_contenido = Contenido.find_by(id: params["idContenido"])
		_contenido.prospecto_id = params["idPros"]
		_contenido.modalidad = params["modalidad"]
		_contenido.certificado = params["certificado"]
		_contenido.objetivo = params["objetivo"]
		_contenido.objetivo_especifico = params["objetivoEsp"]
		_contenido.justificacion = params["justificacion"]
		_contenido.metodologia = params["metodologia"]
		_contenido.descripcion = params["descripcion"]
		_contenido.horas_presenciales = params["presenciales"]
		_contenido.horas_virtuales = params["virtuales"]
		_contenido.horas_autonomas = params["autonomas"]
		if _contenido.save()
			if params["salir"] == "salir"
				return redirect_to("/academico")
			elsif params["salir"] == "guardar"
				redirect_to :controller => 'academico', :action => 'contenido',:curso => params["cursos"],:tipo => "editar", :ids => _contenido.prospecto_id
			else
				redirect_to :controller => 'academico', :action => 'perfilDocente',:curso => params["cursos"],:tipo => "editar", :ids => _contenido.id
			end
		end
	end


	def perfilDocente
		_num = 3 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@tipos = params[:tipo]
		@curso = params[:curso]
		ids = params[:ids]
		if Contenido.exists?(ids)
			_prospectoid = Contenido.find_by(id:ids)
			@contenidoid = ids
			if @tipos == "crear"
				@atras = regresar(_num,@curso,"editar",_prospectoid.prospecto_id)
			elsif @tipos == "editar"
				@atras = regresar(_num,@curso,@tipos,_prospectoid.prospecto_id)
				@perfilPersona = PerfilPersonas.where("contenido_id = ? AND tipo_persona = ?", ids,"Docente")
			else
				return redirect_to("/academico")
			end
		else
			return redirect_to("/academico")
		end
	end


	def createperfilDocente
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			perfilD = PerfilPersonas.new
			perfilD.texto = params["items"][numS]["conocimiento"]
			perfilD.tipo = params["items"][numS]["tipo"]
			perfilD.tipo_requisito =  params["items"][numS]["perfil"]
			perfilD.contenido_id = params["idContenido"]
			perfilD.tipo_persona = "Docente"
			if perfilD.save()
				guardarCorrecto = true
			else
				guardarCorrecto = false
				break
			end
			num = num + 1
		end
		num = 0
		if guardarCorrecto
			if params["salir"] == "true" #cuando se desea salir
				links = "/academico"
				return render json: {link: links},status: :ok
			elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
			else
				links = '/academico/prospecto/estudiante/'+ params["curso"] + '/crear/' + params["idContenido"]
				return render json: {link: links},status: :ok
			end
			
		end
	end


	def editarperfilDocente
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			if params["items"][numS]["id"] == ""
				perfilD = PerfilPersonas.new
				perfilD.texto = params["items"][numS]["conocimiento"]
				perfilD.tipo = params["items"][numS]["tipo"]
				perfilD.tipo_requisito =  params["items"][numS]["perfil"]
				perfilD.contenido_id = params["idContenido"]
				perfilD.tipo_persona = "Docente"
				if perfilD.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			else
				perfilDs = PerfilPersonas.find_by(id: params["items"][numS]["id"])
				perfilDs.texto = params["items"][numS]["conocimiento"]
				perfilDs.tipo = params["items"][numS]["tipo"]
				perfilDs.tipo_requisito = params["items"][numS]["perfil"]
				perfilDs.contenido_id = params["idContenido"]
				perfilDs.tipo_persona = "Docente"
				if perfilDs.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
			num = num + 1
		end
		num = 0
		if params["eliminados"] != ""
			sizeEliminado = params["eliminados"].length
			i = 0
			while i < sizeEliminado
				if destroyPerfil(params["eliminados"][i]) == true
					i = i + 1
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
		end

		if guardarCorrecto
			if params["salir"] == "true"
				links = "/academico"
				return render json: {link: links},status: :ok
			elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
			else
				links = '/academico/prospecto/estudiante/'+ params["curso"] +'/editar/' + params["idContenido"] 
				return render json: {link: links},status: :ok
			end
		end
	end


	def perfilEstudiante
		_num = 4 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@tipos = params[:tipo]
		@curso = params[:curso]
		ids = params[:ids]
		if Contenido.exists?(ids)
			@contenidoid = ids
			if @tipos == "crear"
				@atras = regresar(_num,@curso,"editar",ids)
			elsif @tipos == "editar"
				@atras = regresar(_num,@curso,@tipos,ids)
					@perfilPersona = PerfilPersonas.where("contenido_id = ? AND tipo_persona = ?", ids,"Estudiante")
			else
				return redirect_to("/academico")
			end
		else
			return redirect_to("/academico")
		end
	end


#GUARDAR DATOS DE UNIDADES
	def createperfilEstudiante
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			perfilE = PerfilPersonas.new
			perfilE.texto = params["items"][numS]["conocimiento"]
			perfilE.tipo = params["items"][numS]["tipo"]
			perfilE.tipo_requisito =  params["items"][numS]["perfil"]
			perfilE.contenido_id = params["idContenido"]
			perfilE.tipo_persona = "Estudiante"
			if perfilE.save()
				guardarCorrecto = true
			else
				guardarCorrecto = false
				break
			end
			num = num + 1
		end
		num = 0
		if guardarCorrecto
			if params["salir"] == "true"
				links = "/academico"
				return render json: {link: links},status: :ok
			elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
			else
				links = '/academico/prospecto/unidades/'+params["curso"]+'/crear/'+params["idContenido"]
				return render json: {link: links},status: :ok
			end
		end
		
	end


	def editarperfilEstudiante
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			if params["items"][numS]["id"] == ""
				perfilD = PerfilPersonas.new
				perfilD.texto = params["items"][numS]["conocimiento"]
				perfilD.tipo = params["items"][numS]["tipo"]
				perfilD.tipo_requisito =  params["items"][numS]["perfil"]
				perfilD.contenido_id = params["idContenido"]
				perfilD.tipo_persona = "Estudiante"
				if perfilD.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			else
				perfilDs = PerfilPersonas.find_by(id: params["items"][numS]["id"])
				perfilDs.texto = params["items"][numS]["conocimiento"]
				perfilDs.tipo = params["items"][numS]["tipo"]
				perfilDs.tipo_requisito = params["items"][numS]["perfil"]
				perfilDs.contenido_id = params["idContenido"]
				perfilDs.tipo_persona = "Estudiante"
				if perfilDs.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
			num = num + 1
		end
		num = 0
		if params["eliminados"] != ""
			sizeEliminado = params["eliminados"].length
			i = 0
			while i < sizeEliminado
				if destroyPerfil(params["eliminados"][i]) == true
					i = i + 1
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
		end
		if guardarCorrecto
			if params["salir"] == "true"
				links = "/academico"
				return render json: {link: links},status: :ok
			elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
			else
				links = '/academico/prospecto/unidades/'+params["curso"]+'/editar/'+params["idContenido"]
				return render json: {link: links},status: :ok
			end
			
		end
	end
	

	def unidades
		_num = 5 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@tipos = params[:tipo]
		@curso = params[:curso]
		ids = params[:ids]
		if Contenido.exists?(ids)
			@contenidoid = ids
			if Nivel.exists?(:contenido_id => ids)
				@nivel = Nivel.where("contenido_id = ? AND nivel_id IS NULL", ids)
				@subnivel = Nivel.where("contenido_id = ? AND nivel_id IS NOT NULL", ids)
				@tipos == "editar"
			else
				@tipos == "crear"
				@nivel = ""
				@subnivel = ""
				
			end
			@atras = regresar(_num,@curso,"editar",ids)
		else
			return redirect_to("/academico")
		end
	end


#GUARDAR LOS DATOS DE UNIDADES
	def createUnidades
		num = 0
		tamanioUnidad = params["unidades"].length
		while num < tamanioUnidad
			numS = num.to_s
			unidad = Nivel.new
			unidad.unidad = params["unidades"][numS]["numero"]
			unidad.credito = params["unidades"][numS]["hora"]
			unidad.nombre = params["unidades"][numS]["nombre"]
			unidad.contenido_id = params["idContenido"]
			unidad.nivel_id = nil
			if params["unidades"][numS]["subnivel"] != "" 
				ban = 0
				tamanioSubunidad = params["unidades"][numS]["subnivel"].length
				unidad.save()
				while ban < tamanioSubunidad
					banS = ban.to_s
					subunidad = Nivel.new
					subunidad.unidad = params["unidades"][numS]["subnivel"][banS]["subnumero"]
					subunidad.credito = params["unidades"][numS]["subnivel"][banS]["subhora"]
					subunidad.nombre = params["unidades"][numS]["subnivel"][banS]["subnombre"]
					subunidad.contenido_id = params["idContenido"]
					subunidad.nivel_id = unidad.id
					subunidad.save()
					ban = ban + 1
				end
			else
				unidad.save()
			end
			num = num + 1
		end
		num = 0
		if params["salir"] == "true"
			links = "/academico"
			return render json: {link: links},status: :ok
		elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
		else 
			links = '/academico/prospecto/dirigido/'+params["curso"]+'/crear/'+params["idContenido"]
			return render json: {link: links},status: :ok
		end
	end


	def editarUnidades
		num = 0
		tamanioUnidad = params["unidades"].length
		while num < tamanioUnidad
			numS = num.to_s
			unidadId = 0
			if params["unidades"][numS]["id"] != ""
				unidads = Nivel.find_by(id: params["unidades"][numS]["id"])
				unidads.unidad = params["unidades"][numS]["numero"]
				unidads.credito = params["unidades"][numS]["hora"]
				unidads.nombre =  params["unidades"][numS]["nombre"]
				unidads.contenido_id = params["idContenido"]
				unidads.nivel_id = nil
				unidads.save()
				unidadId = unidads.id
			else
				unidad = Nivel.new
				unidad.unidad = params["unidades"][numS]["numero"]
				unidad.credito = params["unidades"][numS]["hora"]
				unidad.nombre = params["unidades"][numS]["nombre"]
				unidad.contenido_id = params["idContenido"]
				unidad.nivel_id = nil
				unidad.save()
				unidadId = unidad.id
			end
			
			if params["unidades"][numS]["subnivel"] != "" 
				ban = 0
				tamanioSubunidad = params["unidades"][numS]["subnivel"].length
				while ban < tamanioSubunidad
					banS = ban.to_s
					if params["unidades"][numS]["subnivel"][banS]["ids"] != ""
						subunidad = Nivel.find_by(id: params["unidades"][numS]["subnivel"][banS]["ids"])
						subunidad.unidad = params["unidades"][numS]["subnivel"][banS]["subnumero"]
						subunidad.credito = params["unidades"][numS]["subnivel"][banS]["subhora"]
						subunidad.nombre = params["unidades"][numS]["subnivel"][banS]["subnombre"]
						subunidad.contenido_id = params["idContenido"]
						subunidad.nivel_id = unidadId
						subunidad.save()
					else 
						subunidad = Nivel.new
						subunidad.unidad = params["unidades"][numS]["subnivel"][banS]["subnumero"]
						subunidad.credito = params["unidades"][numS]["subnivel"][banS]["subhora"]
						subunidad.nombre = params["unidades"][numS]["subnivel"][banS]["subnombre"]
						subunidad.contenido_id = params["idContenido"]
						subunidad.nivel_id = unidadId
						subunidad.save()
					end
					ban = ban + 1
				end
			end
			num = num + 1
		end
		num = 0
		if params["eliminados"] != ""
			sizeEliminado = params["eliminados"].length
			i = 0
			while i < sizeEliminado
				if eliminarNivel(params["eliminados"][i]) == true
					i = i + 1
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
		end
		if params["salir"] == "true"
			links = "/academico"
			return render json: {link: links},status: :ok
		elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {link: links,mensaje:mensaje},status: :ok
		else 
			links = '/academico/prospecto/dirigido/'+params["curso"]+'/editar/'+params["idContenido"]
			return render json: {link: links},status: :ok
		end
	end
	

	def dirigido
		_num = 6 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		@curso = params[:curso]
		@tipos = params[:tipo]
		ids = params[:ids]
		if Contenido.exists?(ids)
			@contenidoid = ids
			if @tipos == "crear"
				@atras = regresar(_num,@curso,"editar",ids)
			elsif @tipos == "editar"
				@atras = regresar(_num,@curso,@tipos,ids)
				if Dirigido.exists?(:contenido_id => ids)
					@dirigit = Dirigido.where("contenido_id = ? ", ids)
				else
					@tipos = "crear"
				end
			else
				return redirect_to("/academico")
			end
		else
			return redirect_to("/academico")
		end
	end


	def createdirigido
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			dirigido = Dirigido.new
			dirigido.texto =  params["items"][numS]["dirigido"]
			dirigido.tipo = params["items"][numS]["tipo"]
			dirigido.contenido_id = params["idContenido"]
			if dirigido.save()
				guardarCorrecto = true
			else
				guardarCorrecto = false
				break
			end
			num = num + 1
		end
		if guardarCorrecto
			if (params["curso"].eql?("Programa") || params["curso"].eql?("Diplomado")) && params["salir"] == 'false'
				links = '/academico/prospecto/programa/crear/'+params["idContenido"]
				return render json: {linkss: links},status: :ok

			elsif params["salir"] == "truefalse"
				links = ""
				mensaje = "Se guardo exitosamente"
				return render json: {linkss: links,mensaje:mensaje},status: :ok
			else
				
				links = '/academico'
				return render json: {linkss: links},status: :ok
			end
		end
	end


	def editarDirigido
		guardarCorrecto = false
		num = 0
		tamanio = params["items"].length
		while num < tamanio
			numS = num.to_s
			if params["items"][numS]["id"] == ""
				dirigido = Dirigido.new
				dirigido.texto =  params["items"][numS]["dirigido"]
				dirigido.tipo = params["items"][numS]["tipo"]
				dirigido.contenido_id = params["idContenido"]
				if dirigido.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			else
				_dirigido = Dirigido.find_by(id: params["items"][numS]["id"])
				_dirigido.texto =  params["items"][numS]["dirigido"]
				_dirigido.tipo = params["items"][numS]["tipo"]
				_dirigido.contenido_id = params["idContenido"]
				if _dirigido.save()
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
			num = num + 1
		end
		if params["eliminados"] != ""
			sizeEliminado = params["eliminados"].length
			i = 0
			while i < sizeEliminado
				if eliminarDirigido(params["eliminados"][i]) == true
					i = i + 1
					guardarCorrecto = true
				else
					guardarCorrecto = false
					break
				end
			end
		end
		if guardarCorrecto
			if (params["curso"].eql?('Programa') || params["curso"].eql?("Diplomado")) && params["salir"] == "false" 
				links = '/academico/prospecto/programa/editar/'+params["idContenido"]
				return render json: {linkss: links},status: :ok
			elsif params["salir"] == "truefalse"
				links = ''
				mensaje = "Se guardo exitosamente"
				return render json: {linkss: links,mensaje:mensaje},status: :ok
			else
				links = '/academico'
				return render json: {linkss: links},status: :ok
			end
		end
	end


	def programa
		_num = 7 #EL NUMERO DEL LUGAR QUE LE PERTENECE EL FORMULARIO
		curso = 'Programa'
		@tipos = params[:tipo]
		ids = params[:ids]
		if Contenido.exists?(ids)
			_contenido = Contenido.find_by(:id => ids)
			@listaProspct = Prospecto.where("tipo = ? AND prospectos_id IS NULL OR prospectos_id = ?","Curso",_contenido.prospecto_id)
			if Prospecto.exists?(:id => _contenido.prospecto_id)
				@idProspecto = _contenido.prospecto_id
			else
				@idProspecto = ""
			end

			if @tipos == "crear"
				@atras = regresar(_num,curso,"editar",ids)
				@prospectoExistente = ""
			elsif @tipos == "editar"
				@atras = regresar(_num,curso,@tipos,ids)
				if Prospecto.exists?(:prospectos_id => _contenido.prospecto_id)
					@prospectoExistente = Prospecto.where("prospectos_id = ? ", _contenido.prospecto_id)
				else
					@tipos = "crear"
					@prospectoExistente = ""
				end

			else
				return redirect_to("/academico")
			end
		else
			return redirect_to("/academico")
		end
	end


	#CREAR Y ACTUALIZA LOS PROGRAMAS
	def createOrUpdatePrograma
		_prospectoId = params["prospectoIds"]
		if params["tipo"] == "crear"
			begin  
				params["listaCursoSeleccionado"].length.times do |num|
					valorId = params["listaCursoSeleccionado"][num]
					pros = Prospecto.find_by(:id => valorId)
					pros.prospectos_id =  _prospectoId
					pros.save()
				end
			rescue  
			  puts("No existe el campo 'listaCursoSeleccionado' ")  
			end  
		else 
			_booleano = false #USAMOS ESTO COMO BANDERA PARA VERIFICIAR SI EXISTE EL ID EN ARREGLO DEL PARAMETRO 'listaCursoSeleccionado'
			begin  
				if params["listaCursoSeleccionado"].length > 0 && params["listaComparar"].length > 0
					_prospectoExistente = Prospecto.where("prospectos_id = ? AND tipo = ?",_prospectoId,"Curso")
					
					#COMPARAMOS LA LISTA NUEVA('listaCursoSeleccionado') CON LA LISTA VIEJA('listaComparar') PARA IR DESCARTANDO CUANLES SON LOS DATOS QUE DEBEN SER ACTUALIZADOS
					params["listaCursoSeleccionado"].length.times do |num|
						params["listaComparar"].length.times do |old|
							if params["listaComparar"][old] != ""
								if params["listaCursoSeleccionado"][num] == params["listaComparar"][old]
									params["listaCursoSeleccionado"][num] = ""
									params["listaComparar"][old] = ""
								end
							end
						end
					end
					params["listaComparar"].length.times do |old|
						if params["listaComparar"][old] != ""
							pros = Prospecto.find_by(:id => params["listaComparar"][old])
							pros.prospectos_id =  ""
							pros.save()
						end
					end
					params["listaCursoSeleccionado"].length.times do |num|
						if params["listaCursoSeleccionado"][num] != ""
							pros = Prospecto.find_by(:id => params["listaCursoSeleccionado"][num])
							pros.prospectos_id =_prospectoExistente.id
							pros.save()
						end
					end
				end
			rescue  
			  puts("No existe el campo 'listaCursoSeleccionado' ")  
			end 

			begin
			 	if params["listaComparar"].length > 0
					params["listaComparar"].length.times do |old|
						if params["listaComparar"][old] != ""
									pros = Prospecto.find_by(:id => params["listaComparar"][old])
									pros.prospectos_id =  ""
									pros.save()
						end
					end
				end
			rescue 
			 	puts("No existe el campo 'listaComparar' ")
			end 
		end

		begin  
			params["lista"].length.times do |num|
				valorNombre = params["lista"][num]
				prospecto = Prospecto.new
				prospecto.nombre = valorNombre
				prospecto.tipo = "Curso"
				prospecto.prospectos_id = _prospectoId
				prospecto.estado_id = 7 #Estado =>En edicion
				prospecto.save()
			end
		rescue  
			 puts("No existe el campo 'list' ")  
		end  

		case params["salir"]
			when "truefalse" #CUANDO SOLO QUIERE GUARDAR
				mensaje = "Se guardo exitosamente"
				return render json: {link: "",mensaje: mensaje},status: :ok
			when "true" # CUANDO SE DESEA GUARDAR Y LUEGO SALIR
				mensaje = "Se guardo exitosamente"
				links = regresar(0,0,0,0)
				return render json: {link: links,mensaje: mensaje},status: :ok
			when "false" #SOLO QUIERE ENVIAR
				_updateEstadoP = Prospecto.find_by("id = ? ",_prospectoId)
				_updateEstadoP.estado_id = 8
				_updateEstadoP.save()
				_updateEstadoC = Contenido.find_by("prospecto_id = ? AND estado_id = ?",_prospectoId, 7)
				if _updateEstadoC != ""
					_updateEstadoC.estado_id = 8
					_updateEstadoC.save()
				else
					mensaje = "No se pudo guardar ya que debe esperar ha ser aprobado"
					return render json: {link: "",mensaje: mensaje}.to_json,status: :ok
				end
		end
	end


	def ver
		if Prospecto.exists?(params[:id])
			prospecto = Prospecto.buscarProspectoPorId(params[:id])
			if prospecto.estado_id != nil
				estadoProspecto = Estado.find_by(id:prospecto.estado_id).estado
			else
				estadoProspecto = "falta por asignar"
			end
		else
			prospecto = "No existe datos que mostrar"
			estadoProspecto = "No existe datos que mostrar"
		end
		
		if Contenido.exists?(prospecto_id:params[:id])
			contenido = Contenido.buscarContenido(params[:id])
			if contenido.estado_id != nil
				estadoContenido = Estado.find_by(id:contenido.estado_id).estado
			else
				estadoContenido = "falta por asignar"
			end
			if PerfilPersonas.exists?(contenido_id:contenido.id)
				perfilPersonaEstudiante = PerfilPersonas.where("contenido_id = ? AND tipo_persona = ?", contenido.id,"Estudiante")
			else
				perfilPersonaEstudiante = ""
			end
			if PerfilPersonas.exists?(contenido_id:contenido.id)
				perfilPersonaDocente = PerfilPersonas.where("contenido_id = ? AND tipo_persona = ?", contenido.id,"Docente")
			else
				perfilPersonaDocente = ""
			end
			if Nivel.exists?(contenido_id:contenido.id)
				nivel = Nivel.buscarNivel(contenido.id)
			else
				nivel = ""
			end

			if Dirigido.exists?(contenido_id:contenido.id)
				dirigido = Dirigido.buscarDirigido(contenido.id)
			else
				dirigido = ""
			end
		else
			contenido = "No existe datos que mostrar" 
			estadoContenido = "No existe datos que mostrar" 
			dirigido = ""
			nivel = ""
			perfilPersonaDocente  = ""
			perfilPersonaEstudiante = ""
		end
		return render json:{contenidos: contenido,estadoContenido:estadoContenido,prospecto: prospecto,prospectoEstado: estadoProspecto,nivel: nivel,dirigido:  dirigido,perfilDocente: perfilPersonaDocente,perfilEstudiante: perfilPersonaEstudiante} ,status: :ok
	end


	def eliminar
		if Prospecto.exists?(id: params["id"])
			_prospecto = Prospecto.find_by(id: params["id"])
			if _prospecto.estado_id == 7 #estado en edicion
				if Contenido.exists?(prospecto_id: params["id"])
					_contenido = Contenido.where(prospecto_id: params["id"])
					if _contenido.length == 1
						_contenido.each do |contenido|
							if PerfilPersonas.exists?(contenido_id:contenido.id)
								_perfilPersona = PerfilPersonas.where(contenido_id:contenido.id)
								_perfilPersona.destroy_all
							end
							if Nivel.exists?(contenido_id:contenido.id)
								_unidad = Nivel.where(contenido_id:contenido.id)
								_unidad.destroy_all
							end
							if Dirigido.exists?(contenido_id:contenido.id)
								_dirigido = Dirigido.where(contenido_id: contenido.id)
								_dirigido.destroy_all
							end
							
						end
						_contenido.destroy_all
						if _prospecto.tipo == "Programa" || _prospecto.tipo == "Diplomado"
							if Prospecto.exists?(prospectos_id: _prospecto.id)
								_programa = Prospecto.where(prospectos_id: _prospecto.id)
								_programa.each do |prospecto|
									prospecto.prospectos_id = ""
									prospecto.save()
								end
							end
							
						end
						_prospecto.destroy
						return render json:{mensaje: "Prospecto eliminado correctamente",eliminado: "true"}.to_json,status: :ok
					
					elsif _contenido.length == 0
						_prospecto.destroy
						return render json:{mensaje: "Prospecto eliminado correctamente",eliminado: "true"}.to_json,status: :ok
					else
						if Contenido.exists?(prospecto_id: params["id"],estado_id: 7)
							contenido = Contenido.where(prospecto_id: params["id"],estado_id: 7).order(version: :asc).last
							if PerfilPersonas.exists?(contenido_id:contenido.id)
								_perfilPersona = PerfilPersonas.where(contenido_id:contenido.id)
								_perfilPersona.destroy_all
							end
							if Nivel.exists?(contenido_id:contenido.id)
								_unidad = Nivel.where(contenido_id:contenido.id)
								_unidad.destroy_all
							end
							if Dirigido.exists?(contenido_id:contenido.id)
								_dirigido = Dirigido.where(contenido_id: contenido.id)
								_dirigido.destroy_all
							end
							contenido.destroy
							return render json:{mensaje: "Se elimino el contenido",eliminado: "true"}.to_json,status: :ok
						else
							return render json:{mensaje: "No se pudo eliminar, porque no existe contenido en edicion",eliminado: "false"}.to_json,status: :ok
						end
						
					end
				else
					_prospecto.destroy
					return render json:{mensaje: "Prospecto eliminado correctamente",eliminado: "true"}.to_json,status: :ok
				end
				
			else
				_prospecto.estado_id = 9
				_prospecto.save()
				if Contenido.exists?(prospecto_id: params["id"])
					contenido = Contenido.where(prospecto_id: params["id"]).order(version: :asc).last
					contenido.estado_id = 9
					contenido.save()
					return render json:{mensaje: "Se Inactivo  Prospecto y  Contenido  seleccionado",eliminado: "true"}.to_json,status: :ok
				end
				return render json:{mensaje: "Se Inactivo el Prospecto seleccionado",eliminado: "true"}.to_json,status: :ok
			end
		else 
			return render json:{mensaje: "No existe el prospecto que deseas eliminar",eliminado: "false"}.to_json ,status: :ok
		end
	end


#RETORNA TODOS LOS PROSPECTOS SIN IMPORTAR SU ESTADO
	def getProspecto
		return obtenerProspectos(0)
	end


#RETORNA PROSPECTO CON ESTADO EDITAR
	def getEnEdicion
		return obtenerProspectos(7)
	end


	def getPorAprobar
		return obtenerProspectos(8)
	end


	def getPublicado
		return obtenerProspectos(2)
	end


	def getAprobado
		return obtenerProspectos(1)
	end


	def getInactivos
		return obtenerProspectos(9)
	end


#CAMBIA DEL ESTADO DE INACTIVO A EDICION
	def activarEstadosProspectoContenido
		_prospectos = Prospecto.find_by(id: params["id"])
		if _prospectos.estado_id == 9 #estado Inactivo
			_prospectos.estado_id = 7 #estado en edicion
			if Contenido.exists?(prospecto_id: params["id"])
				_contenido = Contenido.where(prospecto_id: params["id"]).order(version: :asc).last
				if _contenido.estado_id == 9
					_contenido.estado_id = 7
					_contenido.save()
				end
			end
		end
		if _prospectos.save()
			return render json: {activado: "true",mensaje: "El prospecto fue activado"}, status: :ok
		else
			return render json: {activado: "false",mensaje: "No se pudo activar"}, status: :ok
		end
	end




	private

#retornar lista de prospectos dependiendo del estado que lo solicita
		def obtenerProspectos(num_estado)
			if num_estado == 0
				prospectos = Prospecto.all
			else
				prospectos = Prospecto.buscarProspectoPorEstado(num_estado)
			end
			listaprospecto = prospectos.map do |pros|
				estados = Estado.find_by(id: pros.estado_id)
				if estados != nil
					state = estados.estado
				else
					state = "sin estado"
				end
				{
						:id => pros.id,
						:nombre => pros.nombre,
						:actualizacion => pros.updated_at,
						:tipo => pros.tipo,
						:estado => state
				}
			end

			return render json: {prospectos: listaprospecto}.to_json, status: :ok
		end


#ELIMINAR LOS PERFILES DEL DOCENTE Y ESTUDIANTE
		def destroyPerfil(id)
			if PerfilPersonas.exists?(id)
				PerfilPersonas.destroy(id)
				return true
			end
			return false
		end


#ELIMINAR LOS CAMPOS DE UNIDADES
		def eliminarNivel(id)
			if Nivel.exists?(id)
				if Nivel.exists?(:nivel_id => id)
					Nivel.destroy_all(nivel_id: id)
					Nivel.destroy(id)
				else
					Nivel.destroy(id)
				end
				return true
			end
			return false
		end


#ELIMINAR LA INFORMACION DEL CAMPO DE DIRIGIDOS
		def eliminarDirigido(id)
			if Dirigido.exists?(id)
				Dirigido.destroy(id)
				return true
			end
			return false
		end


#REGRESAR AL FORMULARIO ANTERIOR DEPENDIENDO DEL num 
		def regresar(num,curso,tipo,id)
			num = num.to_i - 1
			case num
				when 0
					return '/academico'
				when 1
					return "/academico/prospecto/#{tipo}/#{id}/"
				when 2
					return "/academico/prospecto/contenido/#{curso}/#{tipo}/#{id}"
				when 3
					return "/academico/prospecto/docente/#{curso}/#{tipo}/#{id}/"
				when 4
					return "/academico/prospecto/estudiante/#{curso}/#{tipo}/#{id}/"
				when 5
					return "/academico/prospecto/unidades/#{curso}/#{tipo}/#{id}/"
				when 6
					return "/academico/prospecto/dirigido/#{curso}/#{tipo}/#{id}/"
				when 7
					return "/academico/prospecto/programa/#{tipo}/#{id}/"
			end

		end
end