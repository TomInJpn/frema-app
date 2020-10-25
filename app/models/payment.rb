class Payment < ApplicationRecord
  validates :charge_id, presence: true
  validates :quantity,  presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 9999}
  validate  :qtty_max

  belongs_to :item
  belongs_to :user

  private
  def qtty_max
    if self.quantity.present?
      stock = self.item.stock
      errors.add(:quantity, "購入できるのは#{stock}個までです") if self.quantity > stock
    end
  end

end
