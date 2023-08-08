class CreateProductCirculations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_circulations do |t|
      t.references :product, index: true, foreign_key: { on_delete: :cascade }
      
      t.integer :count, null: false

      t.timestamps null: false
    end
  end
end
