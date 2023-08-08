class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, null: false, default: 0

      t.string :phone
      t.string :email
      t.string :name
      t.string :number
      t.string :uid
      t.text :comment
      t.string :city
      t.string :department

      t.boolean :create_account, default: false
      t.boolean :pick_yourself, default: false
      t.boolean :order_complete_sended, null: false, default: false

      t.timestamps null: false
    end

    add_index :orders, :uid
    add_index :orders, :number
  end
end
