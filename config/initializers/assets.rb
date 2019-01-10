# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(boostrap/bootstrap-theme.css)
Rails.application.config.assets.precompile += %w(boostrap/bootstrap.css)
Rails.application.config.assets.precompile += %w(boostrap/bootstrap-theme.min.css)
Rails.application.config.assets.precompile += %w(boostrap/bootstrap.min.css)
Rails.application.config.assets.precompile += %w(boostrap/font-awesome.min.css)
Rails.application.config.assets.precompile += %w(encabezado.css)
Rails.application.config.assets.precompile += %w(sesion.css)
Rails.application.config.assets.precompile += %w(academico.css)
Rails.application.config.assets.precompile += %w(academicoDirigidoPerfilDocenteEstudiante.css)
Rails.application.config.assets.precompile += %w(academicoNew.css)
Rails.application.config.assets.precompile += %w(academicoNivel.css)
Rails.application.config.assets.precompile += %w(academicoContenido.css)

Rails.application.config.assets.precompile += %w(application.js )
Rails.application.config.assets.precompile += %w(js/bootstrap.min.js )
Rails.application.config.assets.precompile += %w(js/jquery-3.3.1.min.js )
Rails.application.config.assets.precompile += %w(sesiones.js )
Rails.application.config.assets.precompile += %w(academicos.js )
Rails.application.config.assets.precompile += %w(formNew.js )
Rails.application.config.assets.precompile += %w(formContenido.js )
Rails.application.config.assets.precompile += %w(formPerfil.js )
Rails.application.config.assets.precompile += %w(formNivel.js )
Rails.application.config.assets.precompile += %w(formPrograma.js )
Rails.application.config.assets.precompile += %w(formDirigido.js )
Rails.application.config.assets.precompile += %w(formGeneral.js )
Rails.application.config.assets.precompile += %w(sondeo.js )
