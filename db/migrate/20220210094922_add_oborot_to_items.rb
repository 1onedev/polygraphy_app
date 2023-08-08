class AddOborotToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :oborot, :integer, null: false, default: 0
  end
end