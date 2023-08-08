class AddColumnToMaterialCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :material_categories, :size, :boolean, default: false
  end
end
