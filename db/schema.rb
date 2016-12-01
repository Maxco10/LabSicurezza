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

ActiveRecord::Schema.define(version: 20161129103926) do

  create_table "announcements", force: :cascade do |t|
    t.string   "titolo"
    t.text     "descrizione"
    t.string   "categoria"
    t.string   "foto"
    t.integer  "etichetta",          default: 0, null: false
    t.integer  "segnalato",          default: 0
    t.integer  "visite",             default: 0
    t.integer  "id_proprietario_id",             null: false
    t.text     "luogo"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "annuncio_id"
    t.integer  "proprietario_id"
    t.integer  "prenotato_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "bookings", ["annuncio_id"], name: "index_bookings_on_annuncio_id"
  add_index "bookings", ["prenotato_id"], name: "index_bookings_on_prenotato_id"
  add_index "bookings", ["proprietario_id"], name: "index_bookings_on_proprietario_id"

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "voto"
    t.integer  "proprietario_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "feedbacks", ["proprietario_id"], name: "index_feedbacks_on_proprietario_id"

  create_table "messages", force: :cascade do |t|
    t.string   "titolo"
    t.string   "testo"
    t.integer  "mittente_id"
    t.integer  "destinatario_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "stato"
  end

  add_index "messages", ["destinatario_id"], name: "index_messages_on_destinatario_id"
  add_index "messages", ["mittente_id"], name: "index_messages_on_mittente_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "nome",                   default: "", null: false
    t.string   "sesso",                  default: "", null: false
    t.string   "foto",                   default: "", null: false
    t.integer  "tipo_utente",            default: 0,  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "ban",                    default: 0
    t.string   "motivo_ban"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
