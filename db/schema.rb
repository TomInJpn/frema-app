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

ActiveRecord::Schema.define(version: 2020_10_10_041715) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "family_name_kanji", default: "", null: false
    t.string "first_name_kanji", default: "", null: false
    t.string "family_name_kana", default: "", null: false
    t.string "first_name_kana", default: "", null: false
    t.string "post_number", default: "", null: false
    t.integer "prefecture_id", null: false
    t.string "city", default: "", null: false
    t.string "block_number", default: "", null: false
    t.string "apartment_name", default: ""
    t.string "phone_number", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "customer_id", null: false
    t.string "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id"
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.string "name", limit: 40, default: "", null: false
    t.text "description", null: false
    t.string "brand", default: ""
    t.integer "condition_id", null: false
    t.integer "shipment_fee_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "shipment_schedule_id", null: false
    t.integer "stock", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "charge_id", null: false
    t.bigint "user_id"
    t.bigint "buyer_id"
    t.integer "item_id", null: false
    t.integer "quantity", null: false
    t.integer "payment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_payments_on_buyer_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "family_name_kanji", default: "", null: false
    t.string "first_name_kanji", default: "", null: false
    t.string "family_name_kana", default: "", null: false
    t.string "first_name_kana", default: "", null: false
    t.date "birthday", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "cards", "users"
  add_foreign_key "images", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "users", column: "buyer_id"
end
