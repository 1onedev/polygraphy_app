class OrdersController < BaseController
  def update
    if current_order.update(order_params)
      case 
      when params[:complete].present?
        ::Orders::Create.call!(
          order: current_order, params: order_params, password: params[:password]
        )

        redirect_to complete_order_path
      when params[:buy_in_click]
        redirect_to cart_path
      else
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :phone,
      :email,
      :name,
      :number,
      :uid,
      :comment,
      :city,
      :department,
      :create_account,
      :pick_yourself,
      items_attributes: [
        :id,
        :price,
        :file,
        :link,
        :item_file_identifier,
        :material_base_id,
        :material_cover_id,
        :material_color_id,
        :material_cover_color_id,
        :product_circulation_id,
        :page_circulation_id,
        :material_size_id,
        :lamination,
        :lak,
        :oborot,
        :stitching
      ]
    ).merge(user: current_user)
  end
end
