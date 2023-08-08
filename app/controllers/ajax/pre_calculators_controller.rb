class Ajax::PreCalculatorsController < ::Ajax::BaseController
  def show
    result = ::Items::PriceCalculator.new(params.to_unsafe_h).call

    render json: { total_price: result, total_price_human: ApplicationController.helpers.price_format(result) }
  end
end
