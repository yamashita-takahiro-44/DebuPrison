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

ActiveRecord::Schema[7.0].define(version: 2023_07_22_135111) do
  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "exercise_type_id", null: false
    t.integer "duration"
    t.integer "calories_burned"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_type_id"], name: "index_exercises_on_exercise_type_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "target_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.integer "calories"
    t.datetime "date_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "content"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "user_badges", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "profile"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.float "current_weight"
  end

  add_foreign_key "exercises", "exercise_types"
  add_foreign_key "exercises", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "meals", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
end
