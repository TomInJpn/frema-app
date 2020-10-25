class Card < ApplicationRecord
  validates :user, uniqueness: true
  validates :customer_id,:card_id, presence: true

  belongs_to :user
end
