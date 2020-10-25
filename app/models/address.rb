class Address < ApplicationRecord
  validates :family_name_kanji,:first_name_kanji,:family_name_kana,:first_name_kana,:post_number,:prefecture_id,:city,:block_number,presence:true
  validates :family_name_kanji,:first_name_kanji,format:{with:/[^\x01-\x7E]+/}
  validates :family_name_kana,:first_name_kana,format:{with:/[ぁ-ん]+/}
  validates :post_number,format:{with:/\d{3}\-\d{4}/}
  validates :phone_number,format:{with:/\d{10,11}|\A\d{0}\z/}

  belongs_to :user, optional: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
