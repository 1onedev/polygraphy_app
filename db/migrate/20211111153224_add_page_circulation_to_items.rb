class AddPageCirculationToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :page_circulation, index: true, foreign_key: { on_delete: :cascade }
  end
end
