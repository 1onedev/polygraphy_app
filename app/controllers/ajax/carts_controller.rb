class Ajax::CartsController < ::Ajax::BaseController
  def create
    cookies_products = cookies[:products].split(',')
    cookies_products << params['product']
    cookies[:products] = cookies_products.compact.join(',')
  end

  def destroy
    cookies_products = cookies[:products].split(',')
    cookies_products -= [params['product']]
    cookies[:products] = cookies_products.compact.join(',')

    @from_cart = params[:from_cart]

    puts @from_cart
  end
end
