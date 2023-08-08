class CreateProductMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :product_materials do |t|
      t.references :product, index: true, foreign_key: { on_delete: :cascade }
      t.references :material, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
