class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user,           foreign_key: true
      t.string  :family_name_kanji, null: false, default: ""
      t.string  :first_name_kanji,  null: false, default: ""
      t.string  :family_name_kana,  null: false, default: ""
      t.string  :first_name_kana,   null: false, default: ""
      t.string  :post_number,       null: false, default: ""
      t.integer :prefecture_id,     null: false, default: nil
      t.string  :city,              null: false, default: ""
      t.string  :block_number,      null: false, default: ""
      t.string  :apartment_name,                 default: ""
      t.string  :phone_number,                   default: ""

      t.timestamps
    end
  end
end
