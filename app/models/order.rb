class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :items, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :items, allow_destroy: true

  has_many :transactions, dependent: :destroy

  validates :number, presence: true, uniqueness: true, on: :update

  scope :search, -> (search) { where("phone ILIKE :search OR name ILIKE :search OR comment ILIKE :search", search: "%#{search}%") if search.present? }

  enum status: {
    uncompleted: 0,
    pending: 1,
    completed: 2
  }

  def total_price
    items.sum(&:total_price)
  end

  def number_with_sign
    ['#', number].join
  end
end