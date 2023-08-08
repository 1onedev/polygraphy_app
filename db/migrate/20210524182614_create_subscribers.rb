class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :email
      t.boolean :viewed, null: false, default: false

      t.timestamps null: false
    end
  end
end
