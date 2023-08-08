class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.string :name
      t.string :name_ru

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.boolean :ctp, default: false

      t.timestamps null: false
    end
  end
end
