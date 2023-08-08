class User::InfosController < ::User::BaseController
  def index
    set_seo(load_page_seo)
  end

  def edit
    set_seo(load_page_edit_seo)
  end

  def update
    if current_user.update(user_params)
      notice = "#{t :date_save}"

      redirect_to user_infos_path
    else
      alert = { error: "#{t :date_error}" }
      render :edit
    end
  end

  def load_page_seo
    OpenStruct.new(seo_title: 'Персональная информация', seo_description: 'Brave - заказывай, печатай, управляй заказами в один клик!', image: '/favicon/ou.jpg')
  end

  def load_page_edit_seo
    OpenStruct.new(seo_title: 'Редактирование персональной информации', seo_description: 'Brave - заказывай, печатай, управляй заказами в один клик!', image: '/favicon/ou.jpg')
  end

  private

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :phone, 
      :image, 
      :company_name, 
      :company_description, 
      :cod_ur, 
      :cod_fiz, 
      :web_site,
      :web_facebook,
      :web_instagram,
      :web_telegram
    )
  end
end
