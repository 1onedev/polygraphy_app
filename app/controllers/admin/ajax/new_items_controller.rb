class Admin::Ajax::NewItemsController < ::Admin::Ajax::BaseController
  def index
    @new_items = Item.where(status: :ogidaet_proverki)
                     .includes(:order)
                     .where(orders: { status: :pending })
  end
end
