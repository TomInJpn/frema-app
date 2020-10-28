# README

* Ruby version 2.5.1

* Ruby on Rails 5.2.4.3

* Database 14.14 Distrib 5.6.47, for osx10.15

* Database initialization rails db:migrate:reset/rails db:seed

## チーム開発との主な相違点

* ヘッダー部
  * ancestryによって、ヘッダー表示のたびに1000個ものSQLを発行していた問題を解消
  * 検索機能を追加
  * パンくずリストを追加(ancestry)
* TOPページ
  * 画面幅により商品一覧表示が崩れる問題を解消
* 商品詳細ページ
  * スライダー作成
* 商品登録・編集ページ
  * 複数枚の画像同時選択機能を追加
  * drag & drop 機能を追加
  * 販売個数欄を追加
  * 商品の説明欄に文字数カウンターを追加
  * 発送元の地域のデフォルトをcurrent_user.addressに変更
* 購入確認ページ
  * 購入数・送料により、支払金額を変更
* ユーザーマイページ
  * デザイン変更
* カテゴリーページを追加(ancestry)
* モデル単体テスト
  * しきい値のテストが無い問題を解消

> チーム開発納期内に単独で1から終了させております。

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
|user_id|references|foreign_key: true|
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
- belongs_to :user, optional: true
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
|buyer_id|references|null: false, foreign_key: true|
|item_id|integer|null: false|
|quantity|integer|null: false|
|payment|integer|null: false|

### Association
- belongs_to :user
- belongs_to :buyer, class_name: "User"
- belongs_to :item


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
- has_many :payments
- has_many :images,dependent: :destroy
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
