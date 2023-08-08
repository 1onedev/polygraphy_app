class Admin::AdminsController < Admin::BaseController
  def index
    @admins = Admin.order(created_at: :desc).search(params[:q]).page(params[:page]).per(10)
  end
  
  def new
    @admin = Admin.new
  end

  def edit
    @admin = load_admin
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @admin = load_admin

    if @admin.update(admin_params)
      respond_to do |format|
        format.html { redirect_to admin_admin_path(@admin) }
        format.js { head :ok }
      end
      notice = "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }
    end
  end

  def destroy
    @admin = load_admin

    @admin.destroy

    redirect_to admin_admins_path, notice: "#{t :date_delete}"
  end

  private

  def load_admin
    Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:admin_role, :name, :email, :password)
  end
end