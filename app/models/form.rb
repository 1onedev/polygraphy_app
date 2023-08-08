class Form < ApplicationRecord
  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }
end