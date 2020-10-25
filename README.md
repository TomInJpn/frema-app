# README

* Ruby version 2.5.1

* Ruby on Rails 5.2.4.3

* Database 14.14 Distrib 5.6.47, for osx10.15

* Database initialization rails db:migrate:reset/rails db:seed

* ...


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false, length: {minimum: 7}|
|password_confirm|string|null: false, length: {minimum: 7}|
|family_name_kanji|string|null: false|
|first_name_kanji|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_day|date|null: false|
### Association
- has_many  :items,   dependent: :destroy
- has_many  :payments,dependent: :destroy
- has_one   :address, dependent: :destroy
- has_one   :card,    dependent: :destroy


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|family_name_kanji|string|null: false|
|first_name_kanji|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_number|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|apartment_name|string||
|phone_number|string||
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user


## paymentsテーブル
|Column|Type|Options|
|------|----|-------|
|charge_id|string|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|quantity|integer|null: false|
### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|category|references|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|brand|string||
|condition_id|integer|null: false|
|shipment_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|shipment_schedule_id|integer|null: false|
|stock|integer|null: false|
|price|integer|null: false|
### Association
- belongs_to :user
- belongs_to :category
- has_many :images
  accepts_nested_attributes_for :images,allow_destroy: true
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipment_fee
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :shipment_schedule


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|image|string|null: false|
### Association
- belongs_to :item
- mount_uploader :image, ImageUploader


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|add_index: true|
### Association
- has_ancestry
- has_many :items
