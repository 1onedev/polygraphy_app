class Admin::NewsandpromosController < Admin::BaseController
  def index
    @newsandpromos = Newsandpromo.order(created_at: :asc).page(params[:page]).per(10)
  end

  def show
    @newsandpromo = load_newsandpromo
  end

  def new
    @newsandpromo = Newsandpromo.new
  end

  def edit
    @newsandpromo = load_newsandpromo
  end

  def create
    @newsandpromo = Newsandpromo.new(newsandpromo_params)

    if @newsandpromo.save
      redirect_to admin_newsandpromo_path(@newsandpromo), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @newsandpromo = load_newsandpromo

    if @newsandpromo.update(newsandpromo_params)
      redirect_to admin_newsandpromo_path(@newsandpromo), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @newsandpromo = load_newsandpromo

    @newsandpromo.destroy

    redirect_to admin_newsandpromos_path, notice: "#{t :date_delete}"
  end

  private

  def load_newsandpromo
    Newsandpromo.friendly.find(params[:id])
  end

  def newsandpromo_params
    params.require(:newsandpromo).permit(
      :name,
      :name_ru,
      :name_en,
      :name_he,
      :tag,
      :tag_ru,
      :tag_en,
      :tag_he,
      :description,
      :description_ru,
      :description_en,
      :description_he,
      :text,
      :text_ru,
      :text_en,
      :text_he,
      :image,
      :image2,
      :image3,
      :image4,
      :published,
      :slug,
      :seo_title,
      :seo_description
    )
  end
end
