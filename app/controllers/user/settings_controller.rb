class User::SettingsController < ::User::BaseController
  def index
  end

  def update
    permited_params = user_params[:password].nil? ? user_params : with_password_user_params

    if current_user.update(permited_params)
      redirect_to user_settings_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:notifications_web, :messages_from_admin, :news_to_mail)
  end

  def with_password_user_params
    params.require(:user).permit(:notifications_web, :messages_from_admin, :news_to_mail, :current_password, :password, :password_confirmation)
  end
end