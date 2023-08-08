class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_create :set_price

  def total_price
    calc_price = self.price || self.product.price
    (calc_price.to_f * count.to_f) rescue 0.0
  end

  private

  def set_price
    self.price = self.product.holiday_cards? ? 0 : self.product.price
  end
end
