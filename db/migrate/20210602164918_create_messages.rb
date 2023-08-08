class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text

      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :admin, index: true, foreign_key: { on_delete: :cascade }

      t.boolean :viewed, null: false, default: false

      t.timestamps null: false
    end
  end
end
