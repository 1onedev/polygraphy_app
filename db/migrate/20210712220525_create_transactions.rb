class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :order, index: true, foreign_key: true, null: false

      t.string :status
      t.string :acq_id
      t.string :completion_date
      t.string :create_date
      t.string :err_code
      t.string :err_description
      t.string :liqpay_order_id
      t.string :payment_id
      t.string :paytype
      t.string :sender_card_bank
      t.string :sender_card_mask2
      t.string :sender_card_type
      t.string :sender_first_name
      t.string :sender_last_name
      t.string :sender_phone
      t.float :amount

      t.timestamps null: false
    end
  end
end
