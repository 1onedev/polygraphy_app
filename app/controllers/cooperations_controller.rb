class CooperationsController < ::BaseController
  layout false

  def create
    Cooperation.create!(cooperation_params)
  end

  private

  def cooperation_params
    params.require(:cooperation).permit(:name, :email, :phone, :text)
  end
end
