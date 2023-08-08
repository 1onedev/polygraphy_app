class Ajax::BaseController < ::BaseController
  layout false
  before_action :initialize_cookies_products
end
