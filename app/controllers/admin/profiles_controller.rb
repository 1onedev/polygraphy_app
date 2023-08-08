class Admin::ProfilesController < Admin::BaseController
  def show
    @current_admin = load_current_admin
  end

  def edit
    @current_admin = load_current_admin
  end

  def update
    @current_admin = load_current_admin

    if @current_admin.update(current_admin_params)
      redirect_to admin_profile_path(@current_admin), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  private

  def load_current_admin
    Admin.find(params[:id])
  end

  def current_admin_params
    params.require(:admin).permit(:name, :email, :image, :password, :password_confirmation)
  end
end