class ProductMaterial < ApplicationRecord
  belongs_to :product
  belongs_to :material

  has_many :product_material_items
end
