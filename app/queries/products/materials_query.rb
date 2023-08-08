module Products
  class MaterialsQuery < ::BaseQuery
    def initialize(product, color: false, size: false)
      @product = product
      @color = color
      @size = size
    end

    def all
      @product.materials
              .joins(:material_category)
              .where(material_categories: { color: @color, size: @size })
              .order('materials.created_at DESC')
    end
  end
end
