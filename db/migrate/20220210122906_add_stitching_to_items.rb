class AddStitchingToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :stitching, :integer, null: false, default: 0
  end
end
