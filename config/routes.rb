Rails.application.routes.draw do
  scope "(:locale)", locale: /uk|ru|en|he/ do
    devise_for :admins
    devise_for :users, controllers: { registrations: 'devise_extended/registrations' }

    namespace :user do
      resources :orders do
        scope module: :orders do
          resources :items
        end
      end
      resources :historys
      resources :messages
      resources :infos
      resources :billings
      resources :settings
      
      delete :delete_image_attachment

      root to: 'orders#index'
    end

    namespace :admin do
      namespace :ajax do
        resources :new_items, only: :index, defaults: { format: :js } 
      end
      resources :admins
      resources :users
      resources :profiles
      resources :partners
      resources :sliders
      resources :newsandpromos
      resources :messages
      resources :reviews
      resources :answers
      resources :feedbacks
      resources :subscribers
      resources :cooperations
      resources :orders do
        scope module: :orders do
          resources :items do
            scope module: :items do
              resources :additional_services
            end
          end
        end
      end
      controller :pages do
        get 'polygraphy_admin', action: :polygraphy_admin, as: :polygraphy_admin
        get 'price_admin', action: :price_admin, as: :price_admin
        get 'ctp_admin', action: :ctp_admin, as: :ctp_admin
        get 'new_orders', action: :new_orders, as: :new_orders
        get 'completed_orders', action: :completed_orders, as: :completed_orders
        get 'files', action: :files, as: :files
      end
      resources :product_categories
      resources :product_tags
      resources :products, only: :show
      resource :documents, only: %i[edit update]
      resources :material_categories
      resource :calculation_settings, only: %i[edit update]
      resources :adminincomes, only: :index
      resources :adminclearincomes, only: :index
      resources :adminjsorders, only: :index
      root to: 'home#index'
    end

    controller :pages do
      get 'contacts', action: :contacts, as: :contacts
      get 'about_company', action: :about_company, as: :about_company
      get 'about_equipment', action: :about_equipment, as: :about_equipment
      get 'about_possibilities', action: :about_possibilities, as: :about_possibilities
      get 'faqs', action: :faqs, as: :faqs
      get 'opt_price', action: :opt_price, as: :opt_price
      get 'payments', action: :payments, as: :payments
      get 'delivery', action: :delivery, as: :delivery
      get 'return', action: :return, as: :return
      get 'protect_your_data', action: :protect_your_data, as: :protect_your_data
      get 'privacy_policy', action: :privacy_policy, as: :privacy_policy
      get 'terms_of_use', action: :terms_of_use, as: :terms_of_use
      get 'complete_order', action: :complete_order, as: :complete_order
    end

    resource  :cart
    resources :payments, param: :uid
    resources :subscribers, only: :create
    resources :cooperations, only: :create
    resources :feedbacks, only: :create
    resources :newsandpromos, only: %i[index show]
    resources :polygraphys, only: %i[index show]
    resources :calculators, only: :index
    resources :ctps, only: :index

    namespace :ajax, defaults: { format: :js } do
      resource  :cart
      resource  :calculations, only: :show
      resource  :pre_calculators, only: :show
      resources :products, only: :show
    end

    resources :orders do
      scope module: :orders do
        resources :items, only: :destroy
      end
    end

    resource :item_files, only: :update

    root to: 'home#index'
  end
end
