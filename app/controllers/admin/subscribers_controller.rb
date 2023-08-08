class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.order(created_at: :desc).page(params[:page]).per(50)

    Subscriber.unviewed.update_all(viewed: true)
  end

  def destroy
    @subscriber = load_subscriber

    @subscriber.destroy

    redirect_to admin_subscribers_path, notice: "#{t :date_delete}"
  end

  private

  def load_subscriber
    Subscriber.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
