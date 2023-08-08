class CreateCooperations < ActiveRecord::Migration[5.2]
  def change
    create_table :cooperations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :text
      t.boolean :agreement, default: false
      t.boolean :viewed, null: false, default: false

      t.timestamps null: false
    end
  end
end
