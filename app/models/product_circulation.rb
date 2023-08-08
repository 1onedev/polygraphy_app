class ProductCirculation < ApplicationRecord
  belongs_to :product, inverse_of: :product_circulations
  has_many :items, inverse_of: :product_circulation, dependent: :nullify
  
  validates :count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def custom_name
    ApplicationController.helpers.count_format(count)
  end
end