class Admin::Orders::ItemsController < Admin::BaseController
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

    redirect_to admin_orders_path
  end

  def update
    @item = load_item

    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to admin_order_path(@item) }
        format.js { head :ok }
      end
      notice = "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }
    end
  end

  private

  def load_item
    Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :status,
      :paid,
      :changed_price,
      :profit
    )
  end
end
