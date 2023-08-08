class Admin::CalculationSettingsController < Admin::BaseController
  def edit
  end

  def update
    if calculation_settings.update!(calculation_settings_params)
      redirect_to edit_admin_calculation_settings_path, notice: "#{t :date_save}"
    else
      redirect_to edit_admin_calculation_settings_path, flash: { error: "#{t :date_error}" }
    end
  end

  private

  def calculation_settings_params
    params.require(:calculation_setting).permit(
      :calculation_variable,
      :calculation_variable_opt,
      :print_price,
      :print_price_opt,
      :time_to_one_color, 
      :print_speed, 
      :work_price,
      :work_price_opt,
      :opt_discount,
      :paint_price,
      :paint_per_paper,
      :podborka_price,
      :scoba_price,
      :skleyka_price,
      :falcovka_price,
      :lamination_price,
      :lak_price,
      :lak_counts
    )
  end
end