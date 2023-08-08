class CreateMaterialCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :material_categories do |t|
      t.string :name
      t.string :name_ru

      t.boolean :color, default: false

      t.string :slug

      t.timestamps null: false
    end
  end
end
