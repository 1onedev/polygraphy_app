class User::BillingsController < ::User::BaseController
  def index
  end

  def update
    if current_user.update(user_params)
      redirect_to user_billings_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }
      render :index
    end
  end

  private


  def user_params
    params.require(:user).permit(:billing_to_check, :billing_card_number, :billing_card_date, :billing_card_cvv)
  end
end