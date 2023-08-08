class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :order, index: true, foreign_key: true, null: false

      t.float :price
      t.integer :count, default: 1, null: false
      t.string :link
      t.attachment :file

      t.timestamps null: false
    end
  end
end
