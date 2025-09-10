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

ActiveRecord::Schema[7.2].define(version: 2025_09_10_204913) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["user_post_id"], name: "index_comments_on_user_post_id"
  end

  create_table "contents", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "category", null: false
    t.string "author", null: false
    t.string "image_url"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_contents_on_category"
    t.index ["published_at"], name: "index_contents_on_published_at"
  end

  create_table "forums", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "likes_count"
    t.integer "comments_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "resource_type", null: false
    t.string "file_url"
    t.string "drive_id"
    t.string "category"
    t.integer "file_size"
    t.string "file_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_resources_on_category"
    t.index ["resource_type"], name: "index_resources_on_resource_type"
  end

  create_table "user_posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "forum_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_id"], name: "index_user_posts_on_forum_id"
    t.index ["user_id"], name: "index_user_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "profile_picture"
    t.string "bio"
    t.string "location"
    t.string "website"
    t.boolean "is_admin", default: false
    t.boolean "is_active", default: true
    t.datetime "last_login_at"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type", default: "Responsável"
    t.string "profile_image_url"
    t.datetime "name_updated_at"
    t.datetime "username_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "user_posts"
  add_foreign_key "comments", "users"
  add_foreign_key "forums", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "user_posts", "forums"
  add_foreign_key "user_posts", "users"
end
