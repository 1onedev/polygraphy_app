class AddColumn2ToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :lamination, :integer, null: false, default: 0
    add_column :items, :lak, :integer, null: false, default: 0
  end
end
