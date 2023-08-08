class User::BaseController < ::BaseController
  layout 'user'

  helper_method :product_tag_applications

  def product_tag_applications
    @product_tag_applications ||= ProductTag.order(name: :asc)
  end
end