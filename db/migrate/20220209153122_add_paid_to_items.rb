class AddPaidToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :paid, :integer, null: false, default: 0
  end
end
