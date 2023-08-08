class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.text :privacy_policy, default: ''
      t.text :terms_of_use, default: ''
      t.text :delivery, default: ''
      t.text :payments, default: ''
      t.text :protect_your_data, default: ''
      t.text :return, default: ''

      t.text :privacy_policy_ru, default: ''
      t.text :terms_of_use_ru, default: ''
      t.text :delivery_ru, default: ''
      t.text :payments_ru, default: ''
      t.text :protect_your_data_ru, default: ''
      t.text :return_ru, default: ''

      t.timestamps null: false
    end
  end
end
