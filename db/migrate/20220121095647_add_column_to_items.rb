class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :changed_price, :float
  end
end
