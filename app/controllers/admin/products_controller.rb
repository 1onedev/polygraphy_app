class Admin::ProductsController < Admin::BaseController
  def show
    @product = load_product

    @product_materials = @product.materials.joins(:material_category).where(material_categories: { color: false }).order('materials.created_at DESC')
    @product_colors = @product.materials.joins(:material_category).where(material_categories: { color: true }).order('materials.created_at DESC')
    @circulations = @product.product_circulations.order('product_circulations.created_at DESC')
  end

  def load_product
    Product.friendly.find(params[:id])
  end
end