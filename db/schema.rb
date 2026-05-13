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

ActiveRecord::Schema[7.1].define(version: 2026_05_13_143228) do
  create_table "nfc_tags", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "label"
    t.string "event_type", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", default: "", null: false
    t.index ["tenant_id"], name: "index_nfc_tags_on_tenant_id"
    t.index ["token"], name: "index_nfc_tags_on_token", unique: true
  end

  create_table "slack_configs", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.string "webhook_url", null: false
    t.string "channel_name"
    t.string "bot_name", default: "TapIn"
    t.text "enter_message"
    t.text "leave_message"
    t.string "allowed_ip_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_slack_configs_on_tenant_id"
  end

  create_table "tap_logs", force: :cascade do |t|
    t.integer "tenant_id", null: false
    t.integer "nfc_tag_id", null: false
    t.string "user_name", null: false
    t.string "event_type", null: false
    t.string "status", null: false
    t.string "skip_reason"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nfc_tag_id"], name: "index_tap_logs_on_nfc_tag_id"
    t.index ["tenant_id"], name: "index_tap_logs_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name", null: false
    t.string "plan", default: "free", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tenant_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "nfc_tags", "tenants"
  add_foreign_key "slack_configs", "tenants"
  add_foreign_key "tap_logs", "nfc_tags"
  add_foreign_key "tap_logs", "tenants"
  add_foreign_key "users", "tenants"
end
