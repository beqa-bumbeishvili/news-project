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

ActiveRecord::Schema.define(version: 20170630150040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at"
  end

  create_table "news_types", force: :cascade do |t|
    t.string "name"
    t.string "id_name"
  end

  create_table "news_versions", force: :cascade do |t|
    t.bigint "news_id"
    t.string "title"
    t.string "content"
    t.datetime "published_at"
    t.bigint "news_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["news_id"], name: "index_news_versions_on_news_id"
    t.index ["news_type_id"], name: "index_news_versions_on_news_type_id"
  end

  add_foreign_key "news_versions", "news"
  add_foreign_key "news_versions", "news_types"
end
