class Material < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true

  belongs_to :material_category, inverse_of: :materials
  
  has_many :product_materials, inverse_of: :material
  accepts_nested_attributes_for :product_materials, allow_destroy: true

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }

  enum paper_format: {
    a2: 0,
    b2: 1
  }

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

  def name_with_size_ctp
    [width,  'x', height, 'мм'].compact.join(' ')
  end

  def name_with_size
    [width, height].compact.join(' + ')
  end

  def name_with_type
    loc_p_type = I18n.t(paper_format)
    pf = "(#{loc_p_type})" unless material_category.color?

    [name, pf].compact.join(' ')
  end
end
