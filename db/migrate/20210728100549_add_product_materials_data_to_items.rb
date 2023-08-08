class AddProductMaterialsDataToItems < ActiveRecord::Migration[5.2]
  def change
    add_column    :items, :product_materials_data, :jsonb, null: false, default: {}
    add_reference :items, :product_circulation, index: true, foreign_key: { on_delete: :cascade }
  end
end
