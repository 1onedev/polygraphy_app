class AddAssemblyTypesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :assembly, :integer, null: false, default: 0
  end
end
