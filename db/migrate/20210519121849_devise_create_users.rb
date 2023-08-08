class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string :name
      t.string :phone
      t.string :company_name
      t.string :cod_ur
      t.string :cod_fiz
      t.text :company_description
      t.string :web_site
      t.string :web_facebook
      t.string :web_instagram
      t.string :web_telegram
      t.string :slug

      t.boolean :billing_to_check, null: false, default: false
      t.string :billing_card_number
      t.string :billing_card_date
      t.string :billing_card_cvv

      t.boolean :notifications_web, null: false, default: true
      t.boolean :messages_from_admin, null: false, default: true
      t.boolean :news_to_mail, null: false, default: true
      t.boolean :privat_policity_confirm, null: false, default: false
      t.boolean :opt_price, null: false, default: false

      t.integer :user_group, null: false, default: 0

      t.attachment :image

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :slug,                 unique: true
  end
end
