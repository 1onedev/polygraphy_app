class Admin::CooperationsController < Admin::BaseController
  def index
    @cooperations = Cooperation.order(created_at: :desc).page(params[:page]).per(10)

    Cooperation.unviewed.update_all(viewed: true)
  end

  def destroy
    @cooperation = load_cooperation

    @cooperation.destroy

    redirect_to admin_cooperations_path, notice: "#{t :date_delete}"
  end

  private

  def load_cooperation
    Cooperation.find(params[:id])
  end

  def cooperation_params
    params.require(:cooperation).permit(:name, :email, :phone, :text, :agreement)
  end
end