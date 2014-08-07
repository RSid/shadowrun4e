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

ActiveRecord::Schema.define(version: 20140807233129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armors", force: true do |t|
    t.string "name",        null: false
    t.string "description"
    t.string "ballistic"
    t.string "impact"
    t.string "legality"
  end

  create_table "character_armors", force: true do |t|
    t.integer "character_id", null: false
    t.integer "armor_id",     null: false
  end

  create_table "character_crafts", force: true do |t|
    t.integer "character_id", null: false
    t.integer "craft_id",     null: false
    t.string  "mods"
  end

  create_table "character_cyberbiowares", force: true do |t|
    t.integer "character_id",    null: false
    t.integer "cyberbioware_id", null: false
    t.integer "rating"
    t.float   "essence_cost",    null: false
  end

  create_table "character_qualities", force: true do |t|
    t.integer "character_id",  null: false
    t.integer "quality_id",    null: false
    t.string  "affect_rating"
  end

  create_table "character_skills", force: true do |t|
    t.integer "character_id",   null: false
    t.integer "skill_id",       null: false
    t.string  "specialization"
    t.integer "rating",         null: false
  end

  create_table "character_tools", force: true do |t|
    t.integer "character_id", null: false
    t.integer "tool_id",      null: false
  end

  create_table "character_weapons", force: true do |t|
    t.integer "character_id", null: false
    t.integer "weapon_id",    null: false
    t.integer "rating"
  end

  create_table "characters", force: true do |t|
    t.string  "name",              null: false
    t.integer "user_id",           null: false
    t.integer "gm_id"
    t.integer "metatype_id",       null: false
    t.integer "body",              null: false
    t.integer "agility",           null: false
    t.integer "reaction",          null: false
    t.integer "strength",          null: false
    t.integer "charisma",          null: false
    t.integer "intuition",         null: false
    t.integer "logic",             null: false
    t.integer "willpower",         null: false
    t.integer "edge",              null: false
    t.integer "nuyen",             null: false
    t.float   "essence",           null: false
    t.integer "magic"
    t.integer "initiative_passes", null: false
    t.text    "bio"
  end

  create_table "connections", force: true do |t|
    t.string  "name",         null: false
    t.string  "description"
    t.integer "loyalty",      null: false
    t.integer "connection",   null: false
    t.integer "character_id", null: false
  end

  create_table "crafts", force: true do |t|
    t.string  "name",         null: false
    t.string  "description"
    t.string  "handling"
    t.string  "acceleration"
    t.integer "pilot"
    t.integer "speed"
    t.integer "body"
    t.integer "armor"
    t.integer "sensor"
  end

  create_table "cyberbiowares", force: true do |t|
    t.string "name",        null: false
    t.string "description"
    t.string "capacity"
    t.string "legality"
  end

  create_table "installs", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "installs", ["email"], name: "index_installs_on_email", unique: true, using: :btree
  add_index "installs", ["reset_password_token"], name: "index_installs_on_reset_password_token", unique: true, using: :btree

  create_table "metatypes", force: true do |t|
    t.string "name",            null: false
    t.string "special_ability"
  end

  create_table "qualities", force: true do |t|
    t.string "name",          null: false
    t.string "description"
    t.string "affected_stat"
  end

  create_table "skills", force: true do |t|
    t.string "name",          null: false
    t.string "default_skill"
    t.string "skill_group"
  end

  create_table "tools", force: true do |t|
    t.string "name",        null: false
    t.string "description"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weapons", force: true do |t|
    t.string  "name",           null: false
    t.text    "description"
    t.string  "damage",         null: false
    t.string  "damage_type",    null: false
    t.boolean "melee",          null: false
    t.string  "concealability"
    t.string  "armor_piercing"
    t.string  "mode"
    t.string  "recoil"
    t.string  "ammo"
    t.string  "legality"
  end

end
