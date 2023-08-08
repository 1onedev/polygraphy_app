class HomeController < BaseController
  def index
    @slides = Slider.order(position: :asc)

    @reviews = Review.order(created_at: :desc)

    @partners = Partner.order(created_at: :desc).limit(6)

    set_seo(load_page_seo)
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('home_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end
end
