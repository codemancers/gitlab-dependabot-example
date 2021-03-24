# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_26_032839) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "repositories", force: :cascade do |t|
    t.boolean "scan"
    t.string "name"
    t.string "description"
    t.string "visibility"
    t.integer "repo_id"
    t.string "web_url"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "namespace_path"
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "updated_packages", force: :cascade do |t|
    t.integer "repository_id"
    t.string "name"
    t.string "package_manager"
    t.string "previous_version"
    t.string "current_version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repository_id"], name: "index_updated_packages_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "gid"
    t.text "bio"
    t.string "email"
    t.string "fullname"
    t.string "handle"
    t.string "picture"
    t.string "access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
