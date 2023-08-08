class CreatePartners < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :name

      t.attachment :image

      t.timestamps null: false
    end
  end
end
