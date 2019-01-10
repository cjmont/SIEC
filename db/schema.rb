# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190110170953) do

  create_table "acciones", force: :cascade do |t|
    t.string   "nombre_accion", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "active_admin_managed_resources", force: :cascade do |t|
    t.string "class_name", limit: 255, null: false
    t.string "action",     limit: 255, null: false
    t.string "name",       limit: 255
  end

  add_index "active_admin_managed_resources", ["class_name", "action", "name"], name: "active_admin_managed_resources_index", unique: true, using: :btree

  create_table "active_admin_permissions", force: :cascade do |t|
    t.integer "managed_resource_id", limit: 4,             null: false
    t.integer "role",                limit: 1, default: 0, null: false
    t.integer "state",               limit: 1, default: 0, null: false
  end

  add_index "active_admin_permissions", ["managed_resource_id", "role"], name: "active_admin_permissions_index", unique: true, using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role",                   limit: 1,   default: 0,  null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "nombre",              limit: 255
    t.string   "nombre_corto",        limit: 255
    t.string   "imagen",              limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "imagen_file_name",    limit: 255
    t.string   "imagen_content_type", limit: 255
    t.integer  "imagen_file_size",    limit: 4
    t.datetime "imagen_updated_at"
    t.string   "sector",              limit: 255
  end

  create_table "articulos", force: :cascade do |t|
    t.string   "titulo",              limit: 255
    t.string   "escritor",            limit: 255
    t.text     "contenido",           limit: 65535
    t.string   "imagen",              limit: 255
    t.integer  "noticia_id",          limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "imagen_file_name",    limit: 255
    t.string   "imagen_content_type", limit: 255
    t.integer  "imagen_file_size",    limit: 4
    t.datetime "imagen_updated_at"
  end

  add_index "articulos", ["noticia_id"], name: "index_articulos_on_noticia_id", using: :btree

  create_table "cliente_corporativos", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "empresa",       limit: 255
    t.string   "nombres",       limit: 255
    t.string   "apellidos",     limit: 255
    t.string   "email",         limit: 255
    t.string   "celular",       limit: 255
    t.string   "cargo",         limit: 255
    t.date     "fecha"
    t.string   "dias",          limit: 255
    t.time     "horaInicio"
    t.time     "horaFin"
    t.integer  "participantes", limit: 4
    t.string   "lugar",         limit: 255
    t.text     "problema",      limit: 65535
    t.string   "nombre_curso",  limit: 255
    t.integer  "estado_id",     limit: 4
    t.string   "tipo_evento",   limit: 255
  end

  add_index "cliente_corporativos", ["estado_id"], name: "index_cliente_corporativos_on_estado_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "nombre",     limit: 500
    t.string   "telefono",   limit: 255
    t.text     "mensaje",    limit: 65535
    t.integer  "estado_id",  limit: 4
  end

  add_index "contacts", ["estado_id"], name: "index_contacts_on_estado_id", using: :btree

  create_table "contenidos", force: :cascade do |t|
    t.string   "modalidad",            limit: 255
    t.string   "certificado",          limit: 255
    t.string   "objetivo",             limit: 300
    t.integer  "horas_presenciales",   limit: 4
    t.string   "requisito_instructor", limit: 255
    t.integer  "version",              limit: 4
    t.text     "objetivo_especifico",  limit: 65535
    t.integer  "prospecto_id",         limit: 4
    t.integer  "especialidad_id",      limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "descripcion",          limit: 500
    t.integer  "precio",               limit: 4
    t.text     "justificacion",        limit: 65535
    t.text     "metodologia",          limit: 65535
    t.integer  "horas_autonomas",      limit: 4
    t.integer  "horas_virtuales",      limit: 4
    t.integer  "estado_id",            limit: 4
  end

  add_index "contenidos", ["especialidad_id"], name: "index_contenidos_on_especialidad_id", using: :btree
  add_index "contenidos", ["estado_id"], name: "index_contenidos_on_estado_id", using: :btree
  add_index "contenidos", ["prospecto_id"], name: "index_contenidos_on_prospecto_id", using: :btree

  create_table "corporativos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dirigidos", force: :cascade do |t|
    t.string   "texto",        limit: 355
    t.string   "tipo",         limit: 255
    t.integer  "contenido_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "dirigidos", ["contenido_id"], name: "index_dirigidos_on_contenido_id", using: :btree

  create_table "especialidads", force: :cascade do |t|
    t.integer  "codigo_SETEC", limit: 4
    t.string   "especialidad", limit: 255
    t.integer  "area_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "especialidads", ["area_id"], name: "index_especialidads_on_area_id", using: :btree

  create_table "estados", force: :cascade do |t|
    t.string "estado", limit: 255, null: false
  end

  create_table "eventos", force: :cascade do |t|
    t.integer  "contenido_id", limit: 4
    t.datetime "fecha_inicio"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "eventos", ["contenido_id"], name: "index_eventos_on_contenido_id", using: :btree

  create_table "intereses", force: :cascade do |t|
    t.integer  "usuario_id",   limit: 4
    t.integer  "area_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "prospecto_id", limit: 4
    t.integer  "estado_id",    limit: 4
    t.text     "observacion",  limit: 65535
  end

  add_index "intereses", ["area_id"], name: "index_intereses_on_area_id", using: :btree
  add_index "intereses", ["estado_id"], name: "index_intereses_on_estado_id", using: :btree
  add_index "intereses", ["prospecto_id"], name: "index_intereses_on_prospectos_id", using: :btree
  add_index "intereses", ["usuario_id"], name: "index_intereses_on_usuario_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "sondeo_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "leads", ["sondeo_id"], name: "index_leads_on_sondeo_id", using: :btree
  add_index "leads", ["usuario_id"], name: "index_leads_on_usuario_id", using: :btree

  create_table "lista", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nivels", force: :cascade do |t|
    t.integer  "unidad",       limit: 4
    t.integer  "credito",      limit: 4
    t.string   "nombre",       limit: 255
    t.integer  "nivel_id",     limit: 4
    t.integer  "contenido_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "nivels", ["contenido_id"], name: "index_nivels_on_contenido_id", using: :btree
  add_index "nivels", ["nivel_id"], name: "index_nivels_on_nivel_id", using: :btree

  create_table "noticias", force: :cascade do |t|
    t.string   "tipo",        limit: 255
    t.integer  "edicion",     limit: 4
    t.date     "publicacion"
    t.string   "redactor",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "participantes", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "evento_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "estado_id",  limit: 4
  end

  add_index "participantes", ["estado_id"], name: "index_participantes_on_estado_id", using: :btree
  add_index "participantes", ["evento_id"], name: "index_participantes_on_evento_id", using: :btree
  add_index "participantes", ["usuario_id"], name: "index_participantes_on_usuario_id", using: :btree

  create_table "pedidos", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "email",      limit: 255
    t.text     "direccion",  limit: 65535
    t.string   "ciudad",     limit: 255
    t.string   "pais",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "telefono",   limit: 255
    t.boolean  "shipped"
  end

  create_table "perfil_personas", force: :cascade do |t|
    t.string   "texto",          limit: 255
    t.string   "tipo",           limit: 255
    t.string   "tipo_requisito", limit: 255
    t.integer  "contenido_id",   limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "tipo_persona",   limit: 255
  end

  add_index "perfil_personas", ["contenido_id"], name: "index_perfil_personas_on_contenido_id", using: :btree

  create_table "permisos", force: :cascade do |t|
    t.string   "sistema",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "rol_id",     limit: 4
  end

  add_index "permisos", ["rol_id"], name: "index_permisos_on_rol_id", using: :btree

  create_table "permisos_acciones", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "permiso_id", limit: 4
    t.integer  "accion_id",  limit: 4
  end

  add_index "permisos_acciones", ["accion_id"], name: "index_permisos_acciones_on_accion_id", using: :btree
  add_index "permisos_acciones", ["permiso_id"], name: "index_permisos_acciones_on_permiso_id", using: :btree

  create_table "prospectos", force: :cascade do |t|
    t.string   "nombre",              limit: 255
    t.string   "linea_negocio",       limit: 255
    t.string   "tipo",                limit: 255
    t.integer  "estado_id",           limit: 4
    t.integer  "area_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "imagen",              limit: 255
    t.string   "imagen_file_name",    limit: 255
    t.string   "imagen_content_type", limit: 255
    t.integer  "imagen_file_size",    limit: 4
    t.datetime "imagen_updated_at"
    t.integer  "prospectos_id",       limit: 4
    t.integer  "curso",               limit: 4
    t.string   "url_video",           limit: 255
  end

  add_index "prospectos", ["area_id"], name: "index_prospectos_on_area_id", using: :btree
  add_index "prospectos", ["estado_id"], name: "index_prospectos_on_estado_id", using: :btree
  add_index "prospectos", ["prospectos_id"], name: "index_prospectos_on_prospectos_id", using: :btree

  create_table "registros", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "rol",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sondeos", force: :cascade do |t|
    t.string   "estado",               limit: 255
    t.integer  "empleado_solicitante", limit: 4
    t.integer  "prospecto_id",         limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "sondeos", ["prospecto_id"], name: "index_sondeos_on_prospecto_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255, null: false
    t.string   "crypted_password", limit: 255
    t.string   "salt",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "usuarioacademicos", force: :cascade do |t|
    t.string   "nombre",                 limit: 255
    t.string   "clave",                  limit: 255
    t.integer  "rol_id",                 limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
  end

  add_index "usuarioacademicos", ["email"], name: "index_usuarioacademicos_on_email", unique: true, using: :btree
  add_index "usuarioacademicos", ["reset_password_token"], name: "index_usuarioacademicos_on_reset_password_token", unique: true, using: :btree
  add_index "usuarioacademicos", ["rol_id"], name: "index_usuarioacademicos_on_rol_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombres",           limit: 255
    t.string   "apellidos",         limit: 255
    t.string   "tipo_id",           limit: 255
    t.string   "identificacion",    limit: 255
    t.date     "fecha_nac"
    t.string   "ciudad",            limit: 255
    t.string   "sexo",              limit: 255
    t.string   "domicilio",         limit: 255
    t.string   "nivel_academico",   limit: 255
    t.string   "titulo",            limit: 255
    t.string   "institucion_proce", limit: 255
    t.string   "profesion",         limit: 255
    t.string   "empresa",           limit: 255
    t.string   "movil",             limit: 255
    t.string   "telefono",          limit: 255
    t.string   "telefono_emp",      limit: 255
    t.string   "email",             limit: 255
    t.string   "nivel_ingreso",     limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password",          limit: 255
    t.text     "cargo",             limit: 65535
  end

  add_foreign_key "articulos", "noticias"
  add_foreign_key "cliente_corporativos", "estados"
  add_foreign_key "contacts", "estados"
  add_foreign_key "contenidos", "especialidads"
  add_foreign_key "contenidos", "estados"
  add_foreign_key "contenidos", "prospectos"
  add_foreign_key "especialidads", "areas"
  add_foreign_key "eventos", "contenidos"
  add_foreign_key "intereses", "areas"
  add_foreign_key "intereses", "estados"
  add_foreign_key "intereses", "usuarios"
  add_foreign_key "leads", "sondeos"
  add_foreign_key "leads", "usuarios"
  add_foreign_key "participantes", "estados"
  add_foreign_key "permisos", "roles"
  add_foreign_key "permisos_acciones", "acciones"
  add_foreign_key "permisos_acciones", "permisos"
  add_foreign_key "prospectos", "areas"
  add_foreign_key "prospectos", "estados"
  add_foreign_key "sondeos", "prospectos"
  add_foreign_key "usuarioacademicos", "roles"
end
