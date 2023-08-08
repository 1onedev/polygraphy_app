class CreateAdditionalServices < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_services do |t|
      t.references :item, index: true, foreign_key: { on_delete: :cascade }

      t.text :name

      t.integer :price

      t.timestamps null: false
    end
  end
end
