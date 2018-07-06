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

ActiveRecord::Schema.define(version: 2017_10_09_153554) do

  create_table "cartify_addresses", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.integer "zip"
    t.string "country"
    t.string "phone"
    t.integer "user_id"
    t.integer "order_id"
    t.index ["order_id"], name: "index_cartify_addresses_on_order_id"
  end

  create_table "cartify_coupons", force: :cascade do |t|
    t.string "name"
    t.decimal "value", precision: 8, scale: 2
  end

  create_table "cartify_credit_cards", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "mm_yy"
    t.string "cvv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cartify_deliveries", force: :cascade do |t|
    t.string "name"
    t.string "duration"
    t.decimal "price", precision: 8, scale: 2
  end

  create_table "cartify_order_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "unit_price", precision: 8, scale: 2
    t.decimal "total_price", precision: 8, scale: 2
    t.integer "product_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_cartify_order_items_on_order_id"
  end

  create_table "cartify_order_statuses", force: :cascade do |t|
    t.string "name"
  end

  create_table "cartify_orders", force: :cascade do |t|
    t.decimal "subtotal", precision: 8, scale: 2
    t.decimal "total", precision: 8, scale: 2
    t.integer "user_id"
    t.integer "order_status_id"
    t.integer "coupon_id"
    t.integer "delivery_id"
    t.integer "credit_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_cartify_orders_on_coupon_id"
    t.index ["credit_card_id"], name: "index_cartify_orders_on_credit_card_id"
    t.index ["delivery_id"], name: "index_cartify_orders_on_delivery_id"
    t.index ["order_status_id"], name: "index_cartify_orders_on_order_status_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
