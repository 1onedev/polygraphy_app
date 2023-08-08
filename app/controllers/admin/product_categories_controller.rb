class Admin::ProductCategoriesController < Admin::BaseController
  def show
    @category = load_category

    @products = @category.products.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @category = ProductCategory.new

    @product_tags = ProductTag.order(name: :asc)
  end

  def edit
    @category = load_category

    @product_tags = ProductTag.order(name: :asc)
  end

  def create
    @category = ProductCategory.new(category_params)

    @product_tags = ProductTag.order(name: :asc)

    if @category.save
      redirect_to admin_product_category_path(@category), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @category = load_category

    @product_tags = ProductTag.order(name: :asc)

    if @category.update(category_params)
      redirect_to admin_product_category_path(@category), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @category = load_category

    @category.products.destroy_all

    @category.destroy

    redirect_to admin_polygraphy_admin_path, notice: "#{t :date_delete}"
  end

  private

  def load_category
    ProductCategory.friendly.find(params[:id])
  end

  def category_params
    params.require(:product_category).permit(
      :name,
      :name_ru,
      :name_en,
      :name_he,
      :ctp,
      products_attributes: [
        :id,
        :name, 
        :name_ru,
        :name_en,
        :name_he,
        :description,
        :description_ru,
        :description_en,
        :description_he,
        :price,
        :width,
        :height,
        :product_tag_id,
        :image,
        :image2,
        :paper_format,
        :assembly,
        :_destroy,
        material_ids: [],
        product_circulations_attributes: [:id, :product_id, :count, :_destroy], page_circulations_attributes: [:id, :product_id, :count, :_destroy]
      ]
    )
  end
end
