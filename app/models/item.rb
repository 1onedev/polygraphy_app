class Item < ApplicationRecord
  belongs_to :order, inverse_of: :items
  belongs_to :product_circulation, inverse_of: :items
  belongs_to :page_circulation, inverse_of: :items, optional: true
  belongs_to :product, inverse_of: :items, optional: true

  has_one :item_file, inverse_of: :item
  accepts_nested_attributes_for :item_file, allow_destroy: true

  has_many :additional_services, dependent: :nullify, inverse_of: :item

  after_create :save_denormalized_data

  jsonb_accessor :product_materials_data, product_name:               [:string, default: nil],
                                          product_name_ru:            [:string, default: nil],
                                          product_description:        [:string, default: nil],
                                          product_description_ru:     [:string, default: nil],
                                          material_base_id:           [:integer, default: nil],
                                          material_base_name:         [:string, default: nil],
                                          material_base_name_ru:      [:string, default: nil],
                                          material_base_height:       [:string, default: nil],
                                          material_base_width:        [:string, default: nil],
                                          material_color_id:          [:integer, default: nil],
                                          material_color_name:        [:string, default: nil],
                                          material_color_name_ru:     [:string, default: nil],
                                          material_color_height:      [:string, default: nil],
                                          material_color_width:       [:string, default: nil],
                                          product_circulation_count:  [:integer, default: 0],
                                          material_color_price:       [:float, default: 0],
                                          calculator_paper_price:     [:float, default: 0],
                                          calculator_color_price:     [:float, default: 0],
                                          calculator_time_price:      [:float, default: 0],
                                          material_cover_id:          [:integer, default: nil],
                                          material_cover_name:        [:string, default: nil],
                                          material_cover_name_ru:     [:string, default: nil],
                                          material_cover_height:      [:string, default: nil],
                                          material_cover_width:       [:string, default: nil],
                                          page_circulation_count:     [:integer, default: 0],
                                          calculator_podborka:        [:float, default: 0],
                                          calculator_scoba:           [:float, default: 0],
                                          calculator_falcovka:        [:float, default: 0],
                                          calculator_cover_price:     [:float, default: 0],
                                          lamination_price:                 [:float, default: 0],
                                          paper_lak:                        [:float, default: 0],
                                          material_cover_color_id:          [:integer, default: nil],
                                          material_cover_color_name:        [:string, default: nil],
                                          material_cover_color_name_ru:     [:string, default: nil],
                                          material_cover_color_height:      [:string, default: nil],
                                          material_cover_color_width:       [:string, default: nil],
                                          material_cover_color_price:       [:float, default: 0],
                                          material_size_id:                 [:integer, default: nil],
                                          material_size_name:               [:string, default: nil],
                                          material_size_name_ru:            [:string, default: nil],
                                          material_size_height:             [:string, default: nil],
                                          material_size_width:              [:string, default: nil],
                                          material_size_price:              [:float, default: 0],
                                          form_price:                       [:float, default: 0],
                                          all_paper_price:                  [:float, default: 0],
                                          form_color_price:                 [:float, default: 0],
                                          stitching_price:                  [:float, default: 0]


  scope :search, ->(query) { where("name LIKE?", "%#{query}%", "%#{query}%") if query.present? }

  enum status: {
    ogidaet_proverki: 0,
    ogidaet_zbornogo_teraga: 1,
    prinat_v_rabotu: 2,
    ogidaet_otpravki: 3,
    dostavlen: 4,
    zavershon: 5,
    error: 6
  }
 
  enum lamination: {
    without_lamination: 0,
    with_lamination: 1
  }

  enum lak: {
    without_lak: 0,
    with_lak: 1
  }

  enum oborot: {
    foreign: 0,
    self: 1
  }

  enum stitching: {
    skleyka: 0,
    scoba: 1
  }

  enum paid: {
    oplacheno: 0,
    neoplacheno: 1
  }

  # relations

  def material_base
    @material_base ||= Material.find_by(id: material_base_id)
  end

  def material_cover
    @material_cover ||= Material.find_by(id: material_cover_id)
  end

  def material_color
    @material_color ||= Material.find_by(id: material_color_id)
  end

  def material_size
    @material_size ||= Material.find_by(id: material_size_id)
  end

  def material_cover_color
    @material_cover_color ||= Material.find_by(id: material_cover_color_id)
  end

  # moved to ItemFile separated model
  # has_attached_file :file
  # validates_attachment :file, content_type: { content_type: /^application\/(pdf|tiff)$/ },
  #                              size: { in: 0..200.megabytes }

  private

  def save_denormalized_data
    self.product_name           = product_circulation&.product&.name
    self.product_name_ru        = product_circulation&.product&.name_ru
    self.product_description    = product_circulation&.product&.description
    self.product_description_ru = product_circulation&.product&.description_ru

    if material_base.present?
      self.material_base_name    = material_base.name
      self.material_base_name_ru = material_base.name_ru
      self.material_base_height  = material_base.height
      self.material_base_width   = material_base.width
    end

    if material_cover.present?
      self.material_cover_name    = material_cover.name
      self.material_cover_name_ru = material_cover.name_ru
      self.material_cover_height  = material_cover.height
      self.material_cover_width   = material_cover.width
    end

    if material_color.present?
      self.material_color_name    = material_color.name
      self.material_color_name_ru = material_color.name_ru
      self.material_color_height  = material_color.height
      self.material_color_width   = material_color.width
      self.material_color_price   = material_color.price
    end

    if material_cover_color.present?
      self.material_cover_color_name    = material_cover_color.name
      self.material_cover_color_name_ru = material_cover_color.name_ru
      self.material_cover_color_height  = material_cover_color.height
      self.material_cover_color_width   = material_cover_color.width
      self.material_cover_color_price   = material_cover_color.price
    end

    if material_size.present?
      self.material_size_name    = material_size.name
      self.material_size_name_ru = material_size.name_ru
      self.material_size_height  = material_size.height
      self.material_size_width   = material_size.width
      self.material_size_price   = material_size.price
    end

    if product_circulation.present?
      self.product_circulation_count = product_circulation.count
    end

    if page_circulation.present?
      self.page_circulation_count = page_circulation.count
    end

    self.product = product_circulation.product

    case 
    when self.product.brochure? || self.product.magazine?
      calculator = ::Items::PriceCalculator.new(
        self.order.user,
        material_base_id: material_base.id, 
        material_color_id: material_color.id,
        material_cover_id: material_cover.id,
        material_cover_color_id: material_cover_color.id,
        product_circulation_id: product_circulation.id,
        page_circulation_id: page_circulation.id,
        lamination: lamination,
        stitching: stitching,
        product_id: product_circulation.product.id
      )
    when self.product.etiketka?
      calculator = ::Items::PriceCalculator.new(
        self.order.user,
        material_base_id: material_base.id, 
        material_color_id: material_color.id,
        product_circulation_id: product_circulation.id,
        material_size_id: material_size.id,
        lak: lak,
        product_id: product_circulation.product.id
      )
    else
      calculator = ::Items::PriceCalculator.new(
        self.order.user,
        material_base_id: material_base.id, 
        material_color_id: material_color.id,
        product_circulation_id: product_circulation.id,
        product_id: product_circulation.product.id,
        oborot: oborot
      )
    end

    calculator.call
    self.calculator_paper_price = calculator.paper_price
    self.calculator_color_price = calculator.color_price
    self.calculator_time_price = calculator.time_price
    self.calculator_podborka = calculator.podborka
    self.calculator_scoba = calculator.scoba
    self.calculator_falcovka = calculator.falcovka
    self.calculator_cover_price = calculator.cover_price
    self.lamination_price = calculator.lamination_price
    self.paper_lak = calculator.paper_lak
    self.form_price = calculator.form_price
    self.all_paper_price = calculator.all_paper_price
    self.form_color_price = calculator.form_color_price
    self.stitching_price = calculator.stitching_price

    self.save!

    ItemFile.find_by(identifier: item_file_identifier)&.update(item: self)
  end
end
