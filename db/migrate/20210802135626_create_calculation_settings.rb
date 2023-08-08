class CreateCalculationSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :calculation_settings do |t|
      t.float :calculation_variable, default: 0
      t.float :calculation_variable_opt, default: 0
      t.integer :print_price, default: 0
      t.integer :print_price_opt, default: 0
      t.integer :time_to_one_color, default: 0
      t.integer :print_speed, default: 0
      t.integer :work_price, default: 0
      t.integer :work_price_opt, default: 0

      t.timestamps null: false
    end
  end
end
