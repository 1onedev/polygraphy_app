class Admin::ReviewsController < Admin::BaseController
  def index
    @reviews = Review.order(created_at: :asc).page(params[:page]).per(10)  
  end

  def new
    @review = Review.new
  end

  def edit
    @review = load_review
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to admin_reviews_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @review = load_review

    if @review.update(review_params)
      redirect_to admin_reviews_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @review = load_review

    @review.destroy

    redirect_to admin_reviews_path, notice: "#{t :date_delete}"
  end

  private

  def load_review
    Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(
      :client,
      :client_ru,
      :client_en,
      :client_he,
      :text,
      :text_ru,
      :text_en,
      :text_he,
      :image
    )
  end
end
