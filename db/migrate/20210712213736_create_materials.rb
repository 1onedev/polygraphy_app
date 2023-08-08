class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.references :material_category, index: true, foreign_key: { on_delete: :cascade }

      t.string :name
      t.string :name_ru

      t.string :height
      t.string :width

      t.float :price ##цена за лист А2
      t.float :price_opt ##цена за лист А2

      t.string :slug

      t.timestamps null: false
    end
  end
end
