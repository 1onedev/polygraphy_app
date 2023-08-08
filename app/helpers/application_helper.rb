module ApplicationHelper
  def truncate_markup(text, length = 30, omission = '...', separator = ' ')
    return if text.blank?

    truncate(strip_tags(text).strip, length: length, omission: omission, separator: separator)
  end

  def admin_roles_tag(resource) 
    case resource.admin_role
    when 'vladelec' then content_tag(:div, t("enums.#{current_admin.admin_role}"), class: 'span badge badge-pill badge-success admin-badge mb-1')
    when 'meneger'  then content_tag(:div, t("enums.#{current_admin.admin_role}"), class: 'span badge badge-pill badge-primary admin-badge mb-1')
    when 'rabotnik' then content_tag(:div, t("enums.#{current_admin.admin_role}"), class: 'span badge badge-pill badge-danger admin-badge mb-1')
    when 'bugalter' then content_tag(:div, t("enums.#{current_admin.admin_role}"), class: 'span badge badge-pill badge-secondary admin-badge mb-1')
    else
      content_tag(:div, t("enums.#{current_admin.admin_role}"))
    end
  end

  def user_groups_tag(resource) 
    case resource.user_group
    when 'ur_lica' then content_tag(:div, t("enums.#{current_user.user_group}"), class: 'span badge badge-pill badge-success admin-badge mb-1')
    when 'fiz_lica'  then content_tag(:div, t("enums.#{current_user.user_group}"), class: 'span badge badge-pill badge-primary admin-badge mb-1')
    when 'tipografia' then content_tag(:div, t("enums.#{current_user.user_group}"), class: 'span badge badge-pill badge-danger admin-badge mb-1')
    when 'posrednik' then content_tag(:div, t("enums.#{current_user.user_group}"), class: 'span badge badge-pill badge-secondary admin-badge mb-1')
    else
      content_tag(:div, t("enums.#{current_user.user_group}"))
    end
  end

  def user_groups_admin_tag(resource) 
    case resource.user_group
    when 'ur_lica' then content_tag(:div, t("enums.#{resource.user_group}"), class: 'span badge badge-pill badge-success admin-badge mb-1')
    when 'fiz_lica'  then content_tag(:div, t("enums.#{resource.user_group}"), class: 'span badge badge-pill badge-primary admin-badge mb-1')
    when 'tipografia' then content_tag(:div, t("enums.#{resource.user_group}"), class: 'span badge badge-pill badge-danger admin-badge mb-1')
    when 'posrednik' then content_tag(:div, t("enums.#{resource.user_group}"), class: 'span badge badge-pill badge-secondary admin-badge mb-1')
    else
      content_tag(:div, t("enums.#{resource.user_group}"))
    end
  end

  def item_status_tag(resource) 
    case resource.status
    when 'ogidaet_proverki' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-warning mb-1')
    when 'ogidaet_zbornogo_teraga' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-warning mb-1')
    when 'prinat_v_rabotu'  then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-info mb-1')
    when 'ogidaet_otpravki' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-secondary mb-1')
    when 'dostavlen' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-primary mb-1')
    when 'zavershon' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-success mb-1')
    when 'error' then content_tag(:div, t("enums.#{resource.status}"), class: 'span badge badge-pill badge-danger mb-1')
    else
      content_tag(:div, t("enums.#{resource.status}"))
    end
  end

  def item_paid_tag(resource)
    case resource.paid
    when 'oplacheno' then content_tag(:div, t("enums.oplacheno"), class: 'badge badge-pill badge-success mb-1')
    when 'neoplacheno'then content_tag(:div, t("enums.neoplacheno"), class: 'badge badge-pill badge-danger mb-1')
    else
      content_tag(:div, t("enums.unpaid"), class: 'badge badge-pill badge-danger mb-1')
    end
  end

  def published_tag(resource)
    if resource.published?
      content_tag(:div, 'Опубликовано', class: 'badge badge-pill badge-success mb-1')
    else
      content_tag(:div, 'Не опубликовано', class: 'badge badge-pill badge-danger mb-1')
    end
  end

  def price_format(price)
    number_to_currency price, precision: 2, unit: "#{t 'price_symbol'}", strip_insignificant_zeros: true, locale: :ua, format: '%n %u'
  end 

  def count_format(count)
    number_to_currency count, precision: 2, unit: "#{t 'count_symbol'}", strip_insignificant_zeros: true, locale: :ua, format: '%n %u'
  end

  def file_format(file_file_size)
    number_to_currency file_file_size, precision: 2, unit: 'byte', strip_insignificant_zeros: true, locale: :ua, format: '(%n %u)'
  end
end
