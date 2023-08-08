class User::Orders::ItemsController < ::User::BaseController
  def destroy
    order = Order.find(params[:order_id])
    item = order.items.find(params[:id])
    additional_services = item.additional_services.all
    
    if item.item_file.present?
      item.item_file.destroy
    else
    end
    if additional_services.present?
      additional_services.destroy_all
    else
    end
    item.destroy

    redirect_to user_orders_path
  end
end
