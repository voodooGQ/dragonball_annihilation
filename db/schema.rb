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

ActiveRecord::Schema.define(version: 2021_04_28_142609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "dimension", default: 15, null: false
  end

  create_table "npcs", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "race"
    t.boolean "flying"
    t.integer "room_id"
    t.integer "starting_area_id"
    t.integer "starting_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "race"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", default: 1, null: false
    t.boolean "admin", default: false
    t.boolean "flying", default: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "x_coord"
    t.integer "y_coord"
    t.integer "sector_id"
    t.integer "area_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name", null: false
    t.string "character_code", limit: 1, null: false
    t.string "symbol"
    t.string "color"
    t.string "alternate_symbol"
    t.string "alternate_color"
  end

end
