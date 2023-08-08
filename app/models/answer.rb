class Answer < ApplicationRecord
  scope :search, ->(query) { where("question ILIKE ?", "%#{query}%") if query.present? }

  def question
    case
    when I18n.locale == :ru && question_ru.present?
      question_ru
    when I18n.locale == :en && question_en.present?
      question_en
    when I18n.locale == :he && question_he.present?
      question_he
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
