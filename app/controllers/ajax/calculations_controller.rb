class Ajax::CalculationsController < ::Ajax::BaseController
  def show
    result = ::Items::PriceCalculator.new(current_user, params.to_unsafe_h).call

    render json: { total_price: result, total_price_human: ApplicationController.helpers.price_format(result) }
  end
end
