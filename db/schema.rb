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

ActiveRecord::Schema[8.0].define(version: 2024_12_23_050113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "artist_details", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "instagram_link"
    t.string "pinterest_link"
    t.string "dribble_link"
    t.string "behance_link"
    t.string "etsy_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_artist_details_on_user_id"
  end

  create_table "artworks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image_url"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_artworks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "artwork_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "replied_to_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_comments_on_artwork_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "following_user_id", null: false
    t.bigint "follower_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_user_id"], name: "index_followers_on_follower_user_id"
    t.index ["following_user_id"], name: "index_followers_on_following_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "artwork_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_likes_on_artwork_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.string "type"
    t.boolean "is_read"
    t.string "action_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "profile_pic_url"
    t.string "phone_number"
    t.boolean "is_active"
    t.string "role"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "artist_details", "users"
  add_foreign_key "artworks", "users"
  add_foreign_key "comments", "artworks"
  add_foreign_key "comments", "comments", column: "replied_to_comment_id"
  add_foreign_key "comments", "users"
  add_foreign_key "followers", "users", column: "follower_user_id"
  add_foreign_key "followers", "users", column: "following_user_id"
  add_foreign_key "likes", "artworks"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "users"
end