class SubscribersController < ::BaseController
  layout false

  def create
    Subscriber.create!(subscriber_params)
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
