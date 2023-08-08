class CreateProductMaterialItems < ActiveRecord::Migration[5.2]
  def change
    create_table :product_material_items do |t|
      t.references :product_material, index: true, foreign_key: { on_delete: :cascade }
      t.references :item, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
