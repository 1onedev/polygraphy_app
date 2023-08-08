class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  helper_method :product_tag_applications
  helper_method :documents
  helper_method :calculation_settings

  def product_tag_applications
    @product_tag_applications ||= ProductTag.order(name: :asc)
  end

  def documents
    @documents ||= Document.instance
  end

  def calculation_settings
    @calculation_settings ||= CalculationSetting.instance
  end
end