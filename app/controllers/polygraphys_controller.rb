class PolygraphysController < BaseController
  def index
    @products = Product.joins(:product_category).where(product_categories: { ctp: false }).by_product_category(params[:product_category]).by_product_tag(params[:product_tag]).order(created_at: :desc).page(params[:page]).per(12)

    @product_categories = ProductCategory.where(ctp: false).order(name: :asc)
    @product_tags = ProductTag.order(name: :asc)

    set_seo(load_page_seo)
  end

  def show
    @product = load_product

    @product_materials = @product.materials.joins(:material_category).where(material_categories: { color: false }).order('materials.created_at DESC')
    @product_colors = @product.materials.joins(:material_category).where(material_categories: { color: true }).order('materials.created_at DESC')
    @cover_materials = @product.materials.joins(:material_category).where(material_categories: { color: false }).order('materials.created_at DESC')
    @cover_colors = @product.materials.joins(:material_category).where(material_categories: { color: true }).order('materials.created_at DESC')
    @circulations = @product.product_circulations.order('product_circulations.created_at DESC')
    @page_circulations = @product.page_circulations.order('page_circulations.created_at DESC')

    set_seo(@product)
  end

  def load_product
    Product.friendly.find(params[:id])
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('polygraphys_page'), seo_description: t('polygraphys_page_description'), image: '/favicon/ou.jpg')
  end
end
