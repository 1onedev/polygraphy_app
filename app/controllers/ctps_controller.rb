class CtpsController < BaseController
  def index
    @product = Product.joins(:product_category).where(product_categories: { ctp: true }).first

    @product_colors = @product.materials.joins(:material_category).where(material_categories: { color: true }).order('materials.created_at DESC')
    @circulations = @product.product_circulations.order('product_circulations.created_at DESC')
    
    set_seo(load_page_seo)
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('making_CTP_page'), seo_description: t('making_CTP_page_description'), image: '/favicon/ou.jpg')
  end
end