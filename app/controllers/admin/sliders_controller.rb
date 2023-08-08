class Admin::SlidersController < Admin::BaseController
  def index
    @sliders = Slider.order(created_at: :asc).page(params[:page]).per(10)
  end

  def show
    @slider = load_slider
  end

  def new
    @slider = Slider.new
  end

  def edit
    @slider = load_slider
  end

  def create
    @slider = Slider.new(slider_params)

    if @slider.save
      redirect_to admin_sliders_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @slider = load_slider

    if @slider.update(slider_params)
      redirect_to admin_sliders_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @slider = load_slider

    @slider.destroy

    redirect_to admin_sliders_path, notice: "#{t :date_delete}"
  end

  private

  def load_slider
    Slider.find(params[:id])
  end

  def slider_params
    params.require(:slider).permit(
      :position,
      :text,
      :text_ru,
      :text_en,
      :text_he,
      :text2,
      :text2_ru,
      :text2_en,
      :text2_he,
      :text3,
      :text3_ru,
      :text3_en,
      :text3_he,
      :button_title,
      :button_title_ru,
      :button_title_en,
      :button_title_he,
      :button_url,
      :image,
      :video
    )
  end
end
