class AddColumn2ToCalculationSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calculation_settings, :lamination_price, :float, default: 0
    add_column :calculation_settings, :lak_price, :float, default: 0  
  end
end
