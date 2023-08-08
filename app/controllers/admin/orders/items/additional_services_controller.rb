class Admin::Orders::Items::AdditionalServicesController < Admin::BaseController
  def create
    @item = Item.find(params[:item_id])

    @additional_service = AdditionalService.new(additional_service_params)

    if @additional_service.save
      redirect_to admin_order_path(@item)
    else
      flash[:alert] = @additional_service.errors.full_messages.join(', ')
      redirect_to admin_order_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    @additional_service = load_additional_service

    @additional_service.destroy

    redirect_to admin_order_path(@item), notice: "#{t :date_delete}"
  end

  private

  def load_additional_service
    AdditionalService.find(params[:id])
  end

  def additional_service_params
    params.require(:additional_service).permit(
      :name,
      :price
    ).merge(item: @item)
  end
end