class User::OrdersController < ::User::BaseController
  def index
    @items = Item.where.not(status: :zavershon).includes(:order).where(orders: { user_id: current_user.id} ).where(orders: { status: :pending }).order(created_at: :desc).limit(10)
  end

  def show
    @item = load_item
  end

  private

  def load_item
    Item.find(params[:id])
  end
end