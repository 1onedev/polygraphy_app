class Orders::ItemsController < ::BaseController
  def destroy
    order = Order.find(params[:order_id])
    item = order.items.find(params[:id])
    
    item.destroy

    redirect_to cart_path
  end
end