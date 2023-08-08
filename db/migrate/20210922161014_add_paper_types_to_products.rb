class AddPaperTypesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :paper_format, :integer, null: false, default: 0
    add_column :materials, :paper_format, :integer, null: false, default: 0
  end
end
