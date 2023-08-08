class AddProductToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :product, index: true, foreign_key: { on_delete: :cascade }
  end
end
