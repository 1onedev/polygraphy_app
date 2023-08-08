class DeviseExtended::RegistrationsController < Devise::RegistrationsController 
  layout :layout_by_resource
  helper_method :current_order
  helper_method :product_tag_applications

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: edit_user_info_path(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # def after_sign_up_path_for(resource)
  #   edit_user_info_path(current_user)
  # end

  def product_tag_applications
    @product_tag_applications ||= ProductTag.order(name: :asc)
  end

  def current_order
    @current_order ||= if cookies[:order_sid].present? && Order.uncompleted.exists?(uid: cookies[:order_sid])
                         Order.uncompleted.find_by(uid: cookies[:order_sid])
                       else
                         uid = SecureRandom.hex(10)
                         cookies[:order_sid] = uid
                         order = Order.create!(status: :uncompleted, uid: uid, user: current_user)
                         order.update!(number: order.id + 1000)
                         order
                       end
  end

  def layout_by_resource
    if user_signed_in?
      "user"
    else
      false
    end
  end
end