class ItemFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :item_files do |t|
      t.references :item, index: true, foreign_key: true
      t.string :identifier

      t.attachment :file

      t.timestamps null: false
    end

    add_column :items, :item_file_identifier, :string
  end
end
