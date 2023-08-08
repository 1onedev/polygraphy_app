class Admin::PartnersController < Admin::BaseController
  def index
    @partners = Partner.order(created_at: :asc).page(params[:page]).per(10)
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = load_partner
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to admin_partners_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @partner = load_partner

    if @partner.update(partner_params)
      redirect_to admin_partners_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @partner = load_partner

    @partner.destroy

    redirect_to admin_partners_path, notice: "#{t :date_delete}"
  end

  private

  def load_partner
    Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(
      :name,
      :image
    )
  end
end
