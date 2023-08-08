class CartsController < BaseController
  def show

    set_seo(load_page_seo)
  end

  def create
    result = Orders::Create.call(
      params: order_params, 
      password: params[:password]
    )
    
    if result.success?
      cookies[:order] = result.order.uid
      cookies[:products] = ''

      process_user if order.create_account?

      redirect_to payment_path(uid: result.order.uid)
    else
      puts "............ order_error #{result.error } ............"
      render action: :show, flash: { error: 'Ошибка создания заказа.' }
    end  
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('carts_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end
  
  private

  def process_user
    user = find_user
    return process_user_order unless user.new_record?
    user.email = order.email if user.email.blank?
    user.phone = order.phone if user.phone.blank?
    user.name = order.name if user.name.blank?
    user.password = prepare_password if user.encrypted_password.blank?
    user.autocomplete_value = autocomplete_value
    user.save!
    process_user_order
  end

  def process_user_order
    order.update!(user: user)
  end

  def find_user
    User.find_by_email(order.email) || User.find_by_phone(order.phone) || User.new
  end

  def prepare_password
    params[:password].present? || SecureRandom.urlsafe_base64(nil, false)
  end

  def user_item_params
    params.require(:order).permit(
      :name, :phone, :city, :department, :comment, 
      :create_account, :email, :pick_yourself,
      order_products_attributes: [:product_id, :count, :_destroy]
    )
  end
end
