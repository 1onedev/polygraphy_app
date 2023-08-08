class AddLakCountToCalcSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calculation_settings, :lak_counts, :float, default: 0
  end
end
