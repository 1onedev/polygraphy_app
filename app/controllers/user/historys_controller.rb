class User::HistorysController < ::User::BaseController
  def index
    @items = Item.where(status: :zavershon).includes(:order).where(orders: { user_id: current_user.id} ).where(orders: { status: :pending }).order(created_at: :desc).limit(10)
  end
end