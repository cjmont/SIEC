Rails.application.routes.draw do
  devise_for :usuarioacademicos
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


resources :prospectos
resources :areas
resources :estados
resources :participantes



  root :to => "sesion#index"
  #root 'sesion#index'
  get 'index' => 'sesion#index'
  post 'verificarSesion' => 'sesion#verificarSesion'
  post 'cerrarSesion' => 'sesion#cerrarSesion'
  #ACADEMICO
  get 'menu' => 'menu#index'
  get 'academico' => 'academico#academico'
  get 'academico/sondeo' => 'academico#sondeo'

  get 'academico/ver/:id' => 'academico#ver'
  get 'getProspecto' => 'academico#getProspecto'
  get 'getPublicado' => 'academico#getPublicado'
  get 'getEnEdicion' => 'academico#getEnEdicion'
  get 'getPorAprobar' => 'academico#getPorAprobar'
  get 'getAprobado' => 'academico#getAprobado'
  get 'getInactivo' => 'academico#getInactivos'

  post 'eliminar' => 'academico#eliminar'
  post 'activar' => 'academico#activarEstadosProspectoContenido'
#CREACION DE SYLLABUS
##SECCION ACADEMICA
###****************************PROSPECTO**************************
  get 'academico/prospecto/:tipo' => 'academico#prospecto'
  get 'academico/prospecto/:tipo/:ids/' => 'academico#prospecto'
  post 'academico/create' => 'academico#createProspecto'
  post 'academico/editar' => 'academico#editProspecto'
###****************************END**************************


###****************************CONTENIDO**************************
  get  'academico/prospecto/contenido/:curso/:tipo/:ids' => 'academico#contenido'
  post 'academico/prospecto/contenido/crearContenido' => 'academico#createContenido'
  post 'academico/prospecto/contenido/editarContenido' => 'academico#editarContenido'
###****************************END**************************


###****************************PERFILPERSONA**************************
####DOCENTE
  get  'academico/prospecto/docente/:curso/:tipo/:ids' => 'academico#perfilDocente'
  post 'academico/prospecto/crearDocente' => 'academico#createperfilDocente'
  post 'academico/prospecto/editarDocente' => 'academico#editarperfilDocente'
####ESTUDIANTE
  get  'academico/prospecto/estudiante/:curso/:tipo/:ids' => 'academico#perfilEstudiante'
  post 'academico/prospecto/crearEstudiante' => 'academico#createperfilEstudiante'
  post 'academico/prospecto/editarEstudiante' => 'academico#editarperfilEstudiante'
###****************************END**************************


###****************************UNIDADES O NIVEL**************************
  get  'academico/prospecto/unidades/:curso/:tipo/:ids' => 'academico#unidades'
  post 'academico/prospecto/crearUnidades' => 'academico#createUnidades'
  post 'academico/prospecto/editarUnidades' => 'academico#editarUnidades'
###****************************END**************************


###****************************DIRIGIDO**************************
  get  'academico/prospecto/dirigido/:curso/:tipo/:ids' => 'academico#dirigido'
  post 'academico/prospecto/crearDirigido' => 'academico#createdirigido'
  post 'academico/prospecto/editarDirigido' => 'academico#editarDirigido'
###****************************END**************************


###****************************PROGRAMA**************************
  get  'academico/prospecto/programa/:tipo/:ids' => 'academico#programa'
  post 'academico/setPrograma' => 'academico#createOrUpdatePrograma'
###****************************END**************************

end
