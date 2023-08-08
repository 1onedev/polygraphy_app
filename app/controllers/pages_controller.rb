class PagesController < BaseController
  def contacts
    set_seo(load_page_contacts_seo)
  end  
  def about_company
    @partners = Partner.order(created_at: :desc).limit(6)

    set_seo(load_page_about_company_seo)
  end
  def about_equipment
    set_seo(load_page_about_equipment_seo)
  end
  def about_possibilities
    set_seo(load_page_about_possibilities_seo)
  end
  def faqs
    @answers = Answer.order(position: :asc).search(params[:q]).page(params[:page]).per(10)

    set_seo(load_page_faqs_seo)
  end
  def opt_price
    set_seo(load_page_opt_price_seo)
  end
  def payments
    @documents = Document.instance

    set_seo(load_page_payments_seo)
  end
  def delivery
    @documents = Document.instance

    set_seo(load_page_delivery_seo)
  end
  def return
    @documents = Document.instance

    set_seo(load_page_return_seo)
  end
  def protect_your_data
    @documents = Document.instance

    set_seo(load_page_protect_your_data_seo)
  end
  def terms_of_use
    @documents = Document.instance

    set_seo(load_page_terms_of_use_seo)
  end
  def privacy_policy
    @documents = Document.instance
    
    set_seo(load_page_privacy_policy_seo)
  end
  def complete_order
    set_seo(load_page_complete_order_seo)
  end

  def load_page_contacts_seo
    OpenStruct.new(seo_title: t('contacts_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_about_company_seo
    OpenStruct.new(seo_title: t('about_company_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_about_equipment_seo
    OpenStruct.new(seo_title: t('about_equipment_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_about_possibilities_seo
    OpenStruct.new(seo_title: t('about_possibilities_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_faqs_seo
    OpenStruct.new(seo_title: t('faqs_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_opt_price_seo
    OpenStruct.new(seo_title: t('opt_price_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_payments_seo
    OpenStruct.new(seo_title: t('payments_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_delivery_seo
    OpenStruct.new(seo_title: t('delivery_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_return_seo
    OpenStruct.new(seo_title: t('return_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_protect_your_data_seo
    OpenStruct.new(seo_title: t('protect_your_data_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_terms_of_use_seo
    OpenStruct.new(seo_title: t('terms_of_use_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_privacy_policy_seo
    OpenStruct.new(seo_title: t('privacy_policy_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end

  def load_page_complete_order_seo
    OpenStruct.new(seo_title: t('complete_order_page'), seo_description: t('seo_description_un'), image: '/favicon/ou.jpg')
  end
end
