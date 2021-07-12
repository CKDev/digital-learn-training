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

ActiveRecord::Schema.define(version: 20210712224531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer "course_id"
    t.string "title"
    t.string "doc_type"
    t.string "file_description"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "tag"
    t.string "slug"
  end

  create_table "course_material_files", force: :cascade do |t|
    t.integer "course_material_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_material_media", force: :cascade do |t|
    t.integer "course_material_id"
    t.string "media_file_name"
    t.string "media_content_type"
    t.integer "media_file_size"
    t.datetime "media_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_material_videos", force: :cascade do |t|
    t.integer "course_material_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_materials", force: :cascade do |t|
    t.string "title", limit: 90
    t.string "summary", limit: 74
    t.text "description"
    t.string "contributor", limit: 156
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sub_category_id"
    t.integer "category_id"
    t.string "pub_status", default: "D"
    t.string "slug"
    t.integer "sort_order", default: 1, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title", limit: 90
    t.string "seo_page_title", limit: 90
    t.string "meta_desc", limit: 156
    t.string "summary", limit: 156
    t.text "description"
    t.text "notes"
    t.string "contributor"
    t.string "pub_status", limit: 2, default: "D"
    t.string "slug"
    t.integer "course_order"
    t.datetime "pub_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "lesson_order"
    t.integer "parent_lesson_id"
    t.string "title", limit: 90
    t.integer "duration"
    t.integer "course_id"
    t.string "slug"
    t.string "summary", limit: 156
    t.string "story_line", limit: 156
    t.string "seo_page_title", limit: 90
    t.string "meta_desc", limit: 156
    t.boolean "is_assessment", default: false, null: false
    t.string "pub_status", limit: 2, default: "D"
    t.string "story_line_file_name"
    t.string "story_line_content_type"
    t.integer "story_line_file_size"
    t.datetime "story_line_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", limit: 90
    t.text "body"
    t.string "pub_status", default: "0", null: false
    t.datetime "pub_at"
    t.string "slug"
    t.string "author", limit: 20
    t.string "seo_title", limit: 90
    t.string "meta_desc", limit: 156
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pub_status"], name: "index_pages_on_pub_status"
    t.index ["title"], name: "index_pages_on_title", unique: true
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "title"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
