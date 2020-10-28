class Item < ApplicationRecord
  validates :name,                  presence: true, length: {maximum: 40}
  validates :description,           presence: true, length: {maximum: 1000}
  validates :condition_id,          presence: true
  validates :shipment_fee_id,       presence: true
  validates :prefecture_id,         presence: true
  validates :shipment_schedule_id,  presence: true
  validates :stock,                 presence: true, numericality:{only_integer: true,greater_than_or_equal_to: 0,less_than_or_equal_to: 9999}
  validates :price,                 presence: true, numericality:{only_integer: true,greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999}

  validates_associated :images
  validates :images,                presence: true
  validate :images_length_validate

  def images_length_validate
    image_max = 10
    errors.add(:images, "は#{image_max}枚以下にしてください") if self.images.size > image_max
  end

  belongs_to :user
  belongs_to :category
  has_many :payments

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images,allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition
  belongs_to :shipment_fee
  belongs_to :prefecture
  belongs_to :shipment_schedule
end
