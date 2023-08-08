class CalculatorsController < BaseController
  def index
    @products = Product.joins(:product_category).where(product_categories: { ctp: false }).order(slug: :asc)

    set_seo(load_page_seo)
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('calculator_page'), seo_description: t('calculator_page_description'), image: '/favicon/ou.jpg')
  end
end
