class Document < ApplicationRecord
  def self.instance
    first_or_create
  end

  def privacy_policy
    case
    when I18n.locale == :ru && privacy_policy_ru.present?
      privacy_policy_ru
    when I18n.locale == :en && privacy_policy_en.present?
      privacy_policy_en
    when I18n.locale == :he && privacy_policy_he.present?
      privacy_policy_he
    else
      super
    end
  end

  def terms_of_use
    case
    when I18n.locale == :ru && terms_of_use_ru.present?
      terms_of_use_ru
    when I18n.locale == :en && terms_of_use_en.present?
      terms_of_use_en
    when I18n.locale == :he && terms_of_use_he.present?
      terms_of_use_he
    else
      super
    end
  end

  def delivery
    case
    when I18n.locale == :ru && delivery_ru.present?
      delivery_ru
    when I18n.locale == :en && delivery_en.present?
      delivery_en
    when I18n.locale == :he && delivery_he.present?
      delivery_he
    else
      super
    end
  end

  def payments
    case
    when I18n.locale == :ru && payments_ru.present?
      payments_ru
    when I18n.locale == :en && payments_en.present?
      payments_en
    when I18n.locale == :he && payments_he.present?
      payments_he
    else
      super
    end
  end

  def protect_your_data
    case
    when I18n.locale == :ru && protect_your_data_ru.present?
      protect_your_data_ru
    when I18n.locale == :en && protect_your_data_en.present?
      protect_your_data_en
    when I18n.locale == :he && protect_your_data_he.present?
      protect_your_data_he
    else
      super
    end
  end

  def return
    case
    when I18n.locale == :ru && return_ru.present?
      return_ru
    when I18n.locale == :en && return_en.present?
      return_en
    when I18n.locale == :he && return_he.present?
      return_he
    else
      super
    end
  end
end
