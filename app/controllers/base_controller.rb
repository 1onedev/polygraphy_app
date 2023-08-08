class BaseController < ApplicationController
  before_action :initialize_cookies_products

  helper_method :product_tag_applications
  helper_method :current_order
  helper_method :calculation_settings

  def product_tag_applications
    @product_tag_applications ||= ProductTag.order(name: :asc)
  end

  def calculation_settings
    @calculation_settings ||= CalculationSetting.instance
  end

  def initialize_cookies_products
    return if cookies[:products]
    cookies[:products] = { value: '', expires: 1.year.from_now }
  end

  def current_order
    @current_order ||= if cookies[:order_sid].present? && Order.uncompleted.exists?(uid: cookies[:order_sid])
                         Order.uncompleted.find_by(uid: cookies[:order_sid])
                       else
                         uid = SecureRandom.hex(10)
                         cookies[:order_sid] = uid
                         order = Order.create!(status: :uncompleted, uid: uid, user: current_user)
                         order.update!(number: order.id + 1000)
                         order
                       end
  end

  def set_seo(page)
    title = page&.seo_title.presence || page&.name 
    description = page&.seo_description  || page&.description
    image = page.try(:image) || page&.cover.url

    set_meta_tags site: 'Polygraphy App',
                  title: title,
                  reverse: false,
                  description: description,
                  twitter: {
                              title: title,
                              description: description,
                              card: 'summary_large_image',
                              image: { _: image }
                            },
                  og: {
                        title: title,
                        description: description,
                        type: 'website',
                        url: request.original_url,
                        image: { _: image }
                      }
  end
end
