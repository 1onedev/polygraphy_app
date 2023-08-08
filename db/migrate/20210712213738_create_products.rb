class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :product_category, index: true, foreign_key: { on_delete: :cascade }
      t.references :product_tag, index: true, foreign_key: { on_delete: :cascade }

      t.string :name
      t.string :name_ru
      t.float :price ##для index
      t.float :quantity ##коло-во для index
      t.text :description
      t.text :description_ru

      t.float :total_price ##цена всего тиража
      t.float :total_quantity ##коло-во всего тиража
      t.float :height ##высота изделия
      t.float :width ##ширина изделия

      t.attachment :image
      t.attachment :image2

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.timestamps null: false
    end
    
    add_index :products, :slug, unique: true
  end
end
