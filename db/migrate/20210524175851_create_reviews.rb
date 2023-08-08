class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :client
      t.string :client_ru
      t.text :text
      t.text :text_ru

      t.attachment :image

      t.timestamps null: false
    end
  end
end
