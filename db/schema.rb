ActiveRecord::Schema.define(version: 2018_11_26_131138) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
