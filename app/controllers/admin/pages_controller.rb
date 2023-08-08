class Admin::PagesController < Admin::BaseController
  def polygraphy_admin
    @product_categories = ProductCategory.where(ctp: false).order(created_at: :asc).page(params[:page]).per(5)

    @product_tags = ProductTag.order(created_at: :asc).page(params[:page]).per(5)
  end

  def price_admin
    @material_categories = MaterialCategory.where(color: false).order(created_at: :asc).page(params[:page]).per(5)

    @material_categories_color = MaterialCategory.find_by(color: true)
    if @material_categories_color.present?
      @colors = @material_categories_color.materials.order(created_at: :asc).page(params[:page]).per(5)
    else
      @colors = MaterialCategory.where(color: false).order(created_at: :asc).page(params[:page]).per(5)
    end
  end

  def ctp_admin
    @product = Product.joins(:product_category).where(product_categories: { ctp: true }).first

    @product_colors = @product.materials.joins(:material_category).order('materials.created_at DESC')
    @circulations = @product.product_circulations.order('product_circulations.created_at DESC')
  end

  def new_orders
    @items = Item.where(status: :ogidaet_proverki).includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
  end

  def completed_orders
    @items = Item.where(status: :zavershon).includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
  end

  def files
    @items = Item.includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
  end
end