class Newsandpromo < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true

  scope :published, -> { where(published: true) }

  def normalize_friendly_id text
    text.to_slug.normalize(transliterations: :ukrainian).to_s
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_attached_file :image, styles: { index: '394x350#', show: '1280x428#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

  has_attached_file :image2, styles: { index: '394x350#', show: '1033x605#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image2, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

  has_attached_file :image3, styles: { index: '394x350#', show: '1033x605#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image3, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

  has_attached_file :image4, styles: { index: '394x350#', show: '1033x605#' },
                            convert_options: { index: '-quality 70', show: '-quality 70'}

  validates_attachment :image4, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

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

  def tag
    case
    when I18n.locale == :ru && tag_ru.present?
      tag_ru
    when I18n.locale == :en && tag_en.present?
      tag_en
    when I18n.locale == :he && tag_he.present?
      tag_he
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

  def text
    case
    when I18n.locale == :ru && text_ru.present?
      text_ru
    when I18n.locale == :en && text_en.present?
      text_en
    when I18n.locale == :he && text_he.present?
      text_he
    else
      super
    end
  end
end
