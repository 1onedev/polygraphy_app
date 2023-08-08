class Admin::OrdersController < Admin::BaseController
  def index
    if params[:from].present? && params[:to].present?
      @items = Item.includes(:order).where('items.created_at >= ? AND items.created_at <= ?', params[:from], params[:to]).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)

      @items_all = Item.where(changed_price: nil).includes(:order).where('items.created_at >= ? AND items.created_at <= ?', params[:from], params[:to]).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
      @items_all_with_changed_price = Item.where.not(changed_price: nil).includes(:order).where('items.created_at >= ? AND items.created_at <= ?', params[:from], params[:to]).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
      @items_all_additional_service = AdditionalService.where(item_id: @items_all.ids)
      @items_all_with_changed_price_additional_service = AdditionalService.where(item_id: @items_all_with_changed_price.ids)
    else
      @items = Item.includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)

      @items_all = Item.where(changed_price: nil).includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
      @items_all_with_changed_price = Item.where.not(changed_price: nil).includes(:order).where(orders: { status: :pending }).order(created_at: :desc).page(params[:page]).per(10)
      @items_all_additional_service = AdditionalService.where(item_id: @items_all.ids)
      @items_all_with_changed_price_additional_service = AdditionalService.where(item_id: @items_all_with_changed_price.ids)
    end
  end

  def show
    @item = load_item

    @additional_services = @item.additional_services.order(created_at: :asc)
  end

  private

  def load_item
    Item.find(params[:id])
  end
end