class ProductMaterialItem < ApplicationRecord
  belongs_to :product_material
  belongs_to :item
end
