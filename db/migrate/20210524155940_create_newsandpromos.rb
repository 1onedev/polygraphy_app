class CreateNewsandpromos < ActiveRecord::Migration[5.2]
  def change
    create_table :newsandpromos do |t|
      t.string :name
      t.string :name_ru
      t.string :tag
      t.string :tag_ru
      t.text :description
      t.text :description_ru
      t.text :text
      t.text :text_ru

      t.attachment :image
      t.attachment :image2
      t.attachment :image3
      t.attachment :image4
      t.boolean :published, null: false, default: false
      
      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.timestamps null: false
    end
  end
end
