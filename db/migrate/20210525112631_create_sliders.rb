class CreateSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :sliders do |t|
      t.integer :position

      t.text :text
      t.text :text_ru
      t.text :text2
      t.text :text2_ru
      t.text :text3
      t.text :text3_ru

      t.string :button_title
      t.string :button_title_ru
      t.string :button_url

      t.attachment :image

      t.timestamps null: false
    end
  end
end
