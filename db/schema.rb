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

ActiveRecord::Schema.define(version: 2019_02_06_030816) do

  create_table "descriptors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type", null: false
    t.string "label", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "entry_at", null: false
    t.text "meal"
    t.bigint "subject_id"
    t.bigint "hunger_level_id"
    t.bigint "energy_level_id"
    t.bigint "concentration_level_id"
    t.bigint "mood_id"
    t.text "physiological_reaction"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concentration_level_id"], name: "index_entries_on_concentration_level_id"
    t.index ["energy_level_id"], name: "index_entries_on_energy_level_id"
    t.index ["hunger_level_id"], name: "index_entries_on_hunger_level_id"
    t.index ["mood_id"], name: "index_entries_on_mood_id"
    t.index ["subject_id"], name: "index_entries_on_subject_id"
  end

end
