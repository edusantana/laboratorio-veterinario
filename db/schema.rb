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

ActiveRecord::Schema.define(version: 20180111130405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["laboratorio_id"], name: "index_exame_requisicoes_on_laboratorio_id"
    t.index ["requisitante_id"], name: "index_exame_requisicoes_on_requisitante_id"
    t.index ["tipo_id"], name: "index_exame_requisicoes_on_tipo_id"
  end

  create_table "exame_tipos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "campos"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_exame_tipos_on_laboratorio_id"
  end

  create_table "laboratorios", force: :cascade do |t|
    t.string "nome", null: false
    t.string "subdomain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_laboratorios_on_subdomain", unique: true
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "exame_requisicoes", "exame_tipos", column: "tipo_id"
  add_foreign_key "exame_requisicoes", "laboratorios"
  add_foreign_key "exame_requisicoes", "users", column: "requisitante_id"
  add_foreign_key "exame_tipos", "laboratorios"
end
