ActiveRecord::Schema.define(version: 2019_01_07_125448) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "expires_on", default: -> { "now()" }, null: false
    t.integer "status", default: 0, null: false
    t.index ["content"], name: "index_tasks_on_content"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["title"], name: "index_tasks_on_title"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
