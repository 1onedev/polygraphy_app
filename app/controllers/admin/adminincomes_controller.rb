class Admin::AdminincomesController < Admin::BaseController
  def index
    days = load_range

    days = params[:date].to_i || 0

    @items_incomes = Item.where(changed_price: nil).includes(:order).where(orders: { status: :pending }).where('items.created_at >= ? AND items.created_at <= ?', load_range[0], load_range[1])
    @items_incomes_with_changed_price = Item.where.not(changed_price: nil).includes(:order).where(orders: { status: :pending }).where('items.created_at >= ? AND items.created_at <= ?', load_range[0], load_range[1])

    @items_incomes_additional_service = AdditionalService.where(item_id: @items_incomes.ids)
    @items_incomes_with_changed_price_additional_service = AdditionalService.where(item_id: @items_incomes_with_changed_price.ids)
    
    respond_to do |format|
      format.html { }
      format.js { render layout: false }
    end
  end

  private

  def load_range
    case params[:date]
    when 'today'
      [Time.zone.now.beginning_of_day, Time.zone.now.end_of_day]
    when 'yesterday'
      [1.day.ago.beginning_of_day, 1.day.ago.end_of_day]
    when 'week'
      [Time.zone.now.beginning_of_week, Time.zone.now.end_of_week]
    when 'months'
      [Time.zone.now.beginning_of_month, Time.zone.now.end_of_month]
    else
      [Time.zone.now.beginning_of_day, Time.zone.now.end_of_day] 
    end
  end
end