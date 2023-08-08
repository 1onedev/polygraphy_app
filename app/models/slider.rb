class Slider < ApplicationRecord
  default_scope { order(position: :asc) }
  
  has_attached_file :image, styles: { index: '1280x720#', admin: '394x350#' },
                            convert_options: { index: '-quality 70', admin: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }
  
  has_attached_file :video
  validates_attachment :video, content_type: { content_type: /^video\/(mp4|avi|mov|mpeg4)$/ },
                               size: { in: 0..20.megabytes }
  

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

  def text2
    case
    when I18n.locale == :ru && text2_ru.present?
      text2_ru
    when I18n.locale == :en && text2_en.present?
      text2_en
    when I18n.locale == :he && text2_he.present?
      text2_he
    else
      super
    end
  end

  def text3
    case
    when I18n.locale == :ru && text3_ru.present?
      text3_ru
    when I18n.locale == :en && text3_en.present?
      text3_en
    when I18n.locale == :he && text3_he.present?
      text3_he
    else
      super
    end
  end

  def button_title
    case
    when I18n.locale == :ru && button_title_ru.present?
      button_title_ru
    when I18n.locale == :en && button_title_en.present?
      button_title_en
    when I18n.locale == :he && button_title_he.present?
      button_title_he
    else
      super
    end
  end
end