class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true

  belongs_to :product_tag, optional: true

  belongs_to :product_category, inverse_of: :products
  
  has_many :product_materials, inverse_of: :product
  accepts_nested_attributes_for :product_materials, allow_destroy: true

  has_many :materials, through: :product_materials

  has_many :product_circulations, inverse_of: :product
  accepts_nested_attributes_for :product_circulations, allow_destroy: true

  has_many :page_circulations, inverse_of: :product
  accepts_nested_attributes_for :page_circulations, allow_destroy: true

  has_many :items, inverse_of: :product

  enum paper_format: {
    a2: 0,
    b2: 1
  }

  enum assembly: {
    standart: 0,
    brochure: 1,
    magazine: 2,
    etiketka: 3
  }

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }
  scope :by_product_category, ->(product_category) { where(product_category: product_category) if product_category.present? }
  scope :by_product_tag, ->(product_tag) { where(product_tag: product_tag) if product_tag.present? }

  has_attached_file :image, styles: { index: '252x252#', show: '395x395#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
  
  has_attached_file :image2, styles: { index: '252x252#', show: '395x395#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image2, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }


  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def name
    case
    when I18n.locale == :ru && name_ru.present?
      name_ru
    when I18n.locale == :en && name_en.present?
      name_en
    when I18n.locale == :he && name_he.present?
      name_he
    else
      super
    end
  end

  def description
    case
    when I18n.locale == :ru && description_ru.present?
      description_ru
    when I18n.locale == :en && description_en.present?
      description_en
    when I18n.locale == :he && description_he.present?
      description_he
    else
      super
    end
  end
end