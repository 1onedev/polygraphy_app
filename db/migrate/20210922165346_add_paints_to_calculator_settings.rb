class AddPaintsToCalculatorSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calculation_settings, :paint_price, :float, default: 0
    add_column :calculation_settings, :paint_per_paper, :float, default: 0
  end
end
