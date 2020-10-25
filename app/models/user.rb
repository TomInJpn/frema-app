class User < ApplicationRecord
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  validates :nickname,:email,:encrypted_password,:family_name_kanji,:first_name_kanji,:family_name_kana,:first_name_kana,:birthday,presence: true
  validates :email, uniqueness:{case_sensitive:false},format:{with: /\A[\w\-._]+@[\w\-._]+\.[a-zA-Z]+\z/}
  validates :encrypted_password,:password,:password_confirmation,length:{minimum:7},format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}
  validates :family_name_kanji,:first_name_kanji,format:{with:/\A[^\x01-\x7Eｦ-ﾟ]+\z/}
  validates :family_name_kana,:first_name_kana,format:{with:/\A[ぁ-ん]+\z/}
  validates :birthday,format:{with:/\A\d{4}\-\d{2}\-\d{2}\z/}

  has_many  :items,   dependent: :destroy
  has_many  :payments,dependent: :destroy
  has_one   :address, dependent: :destroy
  has_one   :card,    dependent: :destroy
end
