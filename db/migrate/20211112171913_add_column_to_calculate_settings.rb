class AddColumnToCalculateSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calculation_settings, :podborka_price, :float, default: 0
    add_column :calculation_settings, :scoba_price, :float, default: 0
    add_column :calculation_settings, :skleyka_price, :float, default: 0
    add_column :calculation_settings, :falcovka_price, :float, default: 0    
  end
end
