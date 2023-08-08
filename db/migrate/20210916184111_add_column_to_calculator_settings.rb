class AddColumnToCalculatorSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calculation_settings, :opt_discount, :integer, default: 0
  end
end
