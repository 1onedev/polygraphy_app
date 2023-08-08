class PageCirculation < ApplicationRecord
  belongs_to :product, inverse_of: :page_circulations, optional: true
  has_many :items, inverse_of: :page_circulations, dependent: :nullify
  
  validates :count, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def custom_name
    ApplicationController.helpers.count_format(count)
  end
end