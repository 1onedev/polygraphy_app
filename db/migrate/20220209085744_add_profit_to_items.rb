class AddProfitToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :profit, :integer, null: false, default: 0
  end
end
