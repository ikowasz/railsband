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

ActiveRecord::Schema[8.0].define(version: 2025_09_21_121203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "song_id", null: false
    t.text "contents"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["song_id"], name: "index_comments_on_song_id"
  end

  create_table "lyrics_annotations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "lyrics_version_id", null: false
    t.uuid "media_file_id"
    t.uuid "comment_id"
    t.integer "line_start"
    t.integer "line_length", default: 1
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["comment_id"], name: "index_lyrics_annotations_on_comment_id"
    t.index ["lyrics_version_id"], name: "index_lyrics_annotations_on_lyrics_version_id"
    t.index ["media_file_id"], name: "index_lyrics_annotations_on_media_file_id"
    t.check_constraint "media_file_id IS NOT NULL OR comment_id IS NOT NULL"
  end

  create_table "lyrics_versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "song_id", null: false
    t.uuid "previous_version_id"
    t.boolean "is_proposal", default: true
    t.text "lyrics", default: ""
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["previous_version_id"], name: "index_lyrics_versions_on_previous_version_id"
    t.index ["song_id", "previous_version_id"], name: "index_lyrics_versions_on_song_and_previous_not_proposal", unique: true, where: "(is_proposal = false)"
    t.index ["song_id"], name: "index_lyrics_versions_on_song_id"
  end

  create_table "media_files", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "song_id", null: false
    t.string "name"
    t.json "file"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["song_id"], name: "index_media_files_on_song_id"
  end

  create_table "songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  add_foreign_key "comments", "songs"
  add_foreign_key "lyrics_annotations", "comments"
  add_foreign_key "lyrics_annotations", "lyrics_versions"
  add_foreign_key "lyrics_annotations", "media_files"
  add_foreign_key "lyrics_versions", "lyrics_versions", column: "previous_version_id"
  add_foreign_key "lyrics_versions", "songs"
  add_foreign_key "media_files", "songs"
end
