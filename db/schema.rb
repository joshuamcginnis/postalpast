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

ActiveRecord::Schema[7.0].define(version: 2022_08_03_205214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "artifacts", force: :cascade do |t|
    t.integer "kind", default: 0
    t.string "addressed_to_name"
    t.string "addressed_from_name"
    t.text "addressed_to_message"
    t.boolean "color", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.datetime "postmarked_at"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "artifact_id", null: false
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "face"
    t.index ["artifact_id"], name: "index_photos_on_artifact_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.bigint "artifact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artifact_id"], name: "index_publishers_on_artifact_id"
  end

  create_table "stamps", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.bigint "artifact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artifact_id"], name: "index_stamps_on_artifact_id"
  end

  add_foreign_key "photos", "artifacts"
  add_foreign_key "publishers", "artifacts"
  add_foreign_key "stamps", "artifacts"
end
