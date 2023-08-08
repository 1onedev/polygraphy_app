class Admin::ProductTagsController < Admin::BaseController
  def new
    @product_tag = ProductTag.new
  end

  def edit
    @product_tag = load_product_tag
  end

  def create
    @product_tag = ProductTag.new(product_tag_params)

    if @product_tag.save
      redirect_to admin_polygraphy_admin_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @product_tag = load_product_tag

    if @product_tag.update(product_tag_params)
      redirect_to admin_polygraphy_admin_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @product_tag = load_product_tag

    @product_tag.destroy

    redirect_to admin_polygraphy_admin_path, notice: "#{t :date_delete}"
  end

  private

  def load_product_tag
    ProductTag.friendly.find(params[:id])
  end

  def product_tag_params
    params.require(:product_tag).permit(:name, :name_ru, :name_en, :name_he)
  end
end