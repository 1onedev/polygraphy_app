class AddEnLocales < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :question_en, :text
    add_column :answers, :text_en, :text

    add_column :documents, :privacy_policy_en, :text, default: ''
    add_column :documents, :terms_of_use_en, :text, default: ''
    add_column :documents, :delivery_en, :text, default: ''
    add_column :documents, :payments_en, :text, default: ''
    add_column :documents, :protect_your_data_en, :text, default: ''
    add_column :documents, :return_en, :text, default: ''

    add_column :materials, :name_en, :string

    add_column :material_categories, :name_en, :string

    add_column :newsandpromos, :name_en, :string
    add_column :newsandpromos, :tag_en, :string
    add_column :newsandpromos, :description_en, :text
    add_column :newsandpromos, :text_en, :text

    add_column :products, :name_en, :string
    add_column :products, :description_en, :text

    add_column :product_categories, :name_en, :string

    add_column :product_tags, :name_en, :string

    add_column :reviews, :client_en, :string
    add_column :reviews, :text_en, :text

    add_column :sliders, :text_en, :text
    add_column :sliders, :text2_en, :text
    add_column :sliders, :text3_en, :text
    add_column :sliders, :button_title_en, :string
  end
end
