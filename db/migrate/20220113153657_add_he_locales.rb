class AddHeLocales < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :question_he, :text
    add_column :answers, :text_he, :text

    add_column :documents, :privacy_policy_he, :text, default: ''
    add_column :documents, :terms_of_use_he, :text, default: ''
    add_column :documents, :delivery_he, :text, default: ''
    add_column :documents, :payments_he, :text, default: ''
    add_column :documents, :protect_your_data_he, :text, default: ''
    add_column :documents, :return_he, :text, default: ''

    add_column :materials, :name_he, :string

    add_column :material_categories, :name_he, :string

    add_column :newsandpromos, :name_he, :string
    add_column :newsandpromos, :tag_he, :string
    add_column :newsandpromos, :description_he, :text
    add_column :newsandpromos, :text_he, :text

    add_column :products, :name_he, :string
    add_column :products, :description_he, :text

    add_column :product_categories, :name_he, :string

    add_column :product_tags, :name_he, :string

    add_column :reviews, :client_he, :string
    add_column :reviews, :text_he, :text

    add_column :sliders, :text_he, :text
    add_column :sliders, :text2_he, :text
    add_column :sliders, :text3_he, :text
    add_column :sliders, :button_title_he, :string
  end
end
