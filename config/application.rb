require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Print
  class Application < Rails::Application
    config.load_defaults 5.2
    config.exceptions_app = self.routes
    config.enable_dependency_loading = true
    config.eager_load_paths << Rails.root.join('lib')
    config.time_zone = 'Kyiv'
    I18n.enforce_available_locales = false
    
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :uk
    I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    I18n.available_locales = [:uk, :ru, :en, :he]
    I18n.default_locale = :uk

    config.action_view.embed_authenticity_token_in_remote_forms = true

    config.to_prepare do
      Devise::SessionsController.layout false
      Devise::ConfirmationsController.layout false
      Devise::UnlocksController.layout false
      Devise::PasswordsController.layout false
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
