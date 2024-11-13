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

ActiveRecord::Schema[7.2].define(version: 2024_11_13_010824) do
  create_table "admins", force: :cascade do |t|
    t.string "user"
    t.string "password"
    t.string "full_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "user"
    t.string "password"
    t.string "email"
    t.string "phone"
    t.string "billing_address"
    t.string "shipping_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fragrances", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "url_img"
    t.text "description"
    t.boolean "availability"
    t.integer "stock"
    t.integer "genre_id", null: false
    t.integer "group_id", null: false
    t.integer "brand_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_fragrances_on_brand_id"
    t.index ["genre_id"], name: "index_fragrances_on_genre_id"
    t.index ["group_id"], name: "index_fragrances_on_group_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer "fragrance_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fragrance_id"], name: "index_images_on_fragrance_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id"
    t.integer "price_at_purchase"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.string "customer"
    t.integer "amount"
    t.string "shipping_address"
    t.string "shipping_email"
    t.string "shipping_date"
    t.integer "order_status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "fragrances", "brands"
  add_foreign_key "fragrances", "genres"
  add_foreign_key "fragrances", "groups"
  add_foreign_key "images", "fragrances"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "order_statuses"
end
