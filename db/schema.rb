# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_28_121704) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "animals", force: :cascade do |t|
    t.boolean "adopted"
    t.integer "age_years"
    t.string "breed"
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "shelter_id", null: false
    t.string "species"
    t.datetime "updated_at", null: false
    t.index ["adopted"], name: "index_animals_available", where: "(adopted = false)"
    t.index ["shelter_id"], name: "index_animals_on_shelter_id"
  end

  create_table "applications", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["animal_id"], name: "index_applications_on_animal_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "shelter_staff", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "role"
    t.bigint "shelter_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["shelter_id"], name: "index_shelter_staff_on_shelter_id"
    t.index ["user_id"], name: "index_shelter_staff_on_user_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "state"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "animals", "shelters"
  add_foreign_key "applications", "animals"
  add_foreign_key "applications", "users"
  add_foreign_key "shelter_staff", "shelters"
  add_foreign_key "shelter_staff", "users"
end
