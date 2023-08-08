class MaterialCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true

  has_many :materials, dependent: :nullify, inverse_of: :material_category
  accepts_nested_attributes_for :materials, allow_destroy: true

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") if query.present? }

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
end
