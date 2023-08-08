class Review < ApplicationRecord
  has_attached_file :image, styles: { index: '80x80#' },
                            convert_options: { index: '-quality 70' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpeg|jpg|png|gif)$/ },
                               size: { in: 0..5.megabytes }

  
  def client
    case
    when I18n.locale == :ru && client_ru.present?
      client_ru
    when I18n.locale == :en && client_en.present?
      client_en
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