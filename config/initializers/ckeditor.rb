# Use this hook to configure ckeditor
Ckeditor.setup do |config|

  require 'ckeditor/orm/active_record'

  # handle custom addons
  assets_root =  Rails.root.join('app','assets','javascripts')
end
