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

ActiveRecord::Schema.define(version: 20180218175016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atendimentos", force: :cascade do |t|
    t.text "anamnese"
    t.float "peso"
    t.float "temperatura_retal"
    t.float "batimentos_cardiaco"
    t.float "frequencia_respiratoria"
    t.text "observacoes"
    t.text "achados_clinicos"
    t.text "exames_complementares"
    t.text "diagnostico_presuntivo"
    t.string "terapia_do_presuntivo"
    t.text "diagnostico_definitivo"
    t.text "terapia_do_definitivo"
    t.bigint "paciente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paciente_id"], name: "index_atendimentos_on_paciente_id"
  end

  create_table "clinicas", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organizacao_id"
    t.index ["organizacao_id"], name: "index_clinicas_on_organizacao_id"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "cidade"
    t.string "endereco"
    t.string "numero"
    t.string "complemento"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exame_anexos", force: :cascade do |t|
    t.bigint "resultado_id"
    t.string "anexo_file_name"
    t.string "anexo_content_type"
    t.integer "anexo_file_size"
    t.datetime "anexo_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.index ["resultado_id"], name: "index_exame_anexos_on_resultado_id"
  end

  create_table "exame_imagens", force: :cascade do |t|
    t.bigint "resultado_id"
    t.string "imagem_file_name"
    t.string "imagem_content_type"
    t.integer "imagem_file_size"
    t.datetime "imagem_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.index ["resultado_id"], name: "index_exame_imagens_on_resultado_id"
  end

  create_table "exame_requisicoes", force: :cascade do |t|
    t.bigint "tipo_id", null: false
    t.bigint "requisitante_id", null: false
    t.string "proprietario"
    t.string "nome"
    t.integer "idade"
    t.string "especie"
    t.string "raca"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "laboratorio_id", null: false
    t.string "aasm_state"
    t.string "suspeita_clinica"
    t.index ["laboratorio_id"], name: "index_exame_requisicoes_on_laboratorio_id"
    t.index ["requisitante_id"], name: "index_exame_requisicoes_on_requisitante_id"
    t.index ["tipo_id"], name: "index_exame_requisicoes_on_tipo_id"
  end

  create_table "exame_resultados", force: :cascade do |t|
    t.bigint "requisicao_id"
    t.bigint "tecnico_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requisicao_id"], name: "index_exame_resultados_on_requisicao_id", unique: true
    t.index ["tecnico_id"], name: "index_exame_resultados_on_tecnico_id"
  end

  create_table "exame_tipos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "campos"
    t.bigint "laboratorio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "valor"
    t.index ["laboratorio_id"], name: "index_exame_tipos_on_laboratorio_id"
  end

  create_table "familias", force: :cascade do |t|
    t.bigint "clinica_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinica_id"], name: "index_familias_on_clinica_id"
  end

  create_table "laboratorios", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "apresentacao"
    t.bigint "organizacao_id"
    t.index ["organizacao_id"], name: "index_laboratorios_on_organizacao_id"
  end

  create_table "organizacoes", force: :cascade do |t|
    t.bigint "dono_id"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "experimental", default: false
    t.index ["dono_id"], name: "index_organizacoes_on_dono_id"
    t.index ["subdomain"], name: "index_organizacoes_on_subdomain", unique: true
  end

  create_table "pacientes", force: :cascade do |t|
    t.string "nome", null: false
    t.boolean "sexo"
    t.string "especie"
    t.date "data_nascimento"
    t.string "raca"
    t.boolean "vivo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "familia_id"
    t.index ["familia_id"], name: "index_pacientes_on_familia_id"
    t.index ["nome"], name: "index_pacientes_on_nome"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "tutores", force: :cascade do |t|
    t.string "nome"
    t.boolean "sexo"
    t.string "cpf"
    t.string "email"
    t.string "telefones"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "familia_id"
    t.index ["familia_id"], name: "index_tutores_on_familia_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "nome", null: false
    t.bigint "laboratorio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "endereco"
    t.string "telefone"
    t.index ["laboratorio_id"], name: "index_unidades_on_laboratorio_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome"
    t.string "cpf"
    t.string "crmv"
    t.string "telefone"
    t.text "endereco"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "atendimentos", "pacientes"
  add_foreign_key "clinicas", "organizacoes"
  add_foreign_key "exame_anexos", "exame_resultados", column: "resultado_id"
  add_foreign_key "exame_imagens", "exame_resultados", column: "resultado_id"
  add_foreign_key "exame_requisicoes", "exame_tipos", column: "tipo_id"
  add_foreign_key "exame_requisicoes", "laboratorios"
  add_foreign_key "exame_requisicoes", "users", column: "requisitante_id"
  add_foreign_key "exame_resultados", "exame_requisicoes", column: "requisicao_id"
  add_foreign_key "exame_resultados", "users", column: "tecnico_id"
  add_foreign_key "exame_tipos", "laboratorios"
  add_foreign_key "familias", "clinicas"
  add_foreign_key "laboratorios", "organizacoes"
  add_foreign_key "organizacoes", "users", column: "dono_id"
  add_foreign_key "pacientes", "familias"
  add_foreign_key "tutores", "familias"
  add_foreign_key "unidades", "laboratorios"
end
