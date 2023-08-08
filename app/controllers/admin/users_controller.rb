class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc).search(params[:q]).page(params[:page]).per(10)
  end

  def show
    @user = load_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = load_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @user = load_user

    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to admin_user_path(@user) }
        format.js { head :ok }
      end
      notice = "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }
    end
  end

  def destroy
    @user = load_user

    @user.destroy

    redirect_to admin_users_path, notice: "#{t :date_delete}"
  end

  private

  def load_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:opt_price, :name, :email, :password, :user_group, :phone)
  end
end