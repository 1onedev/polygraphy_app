class Admin::MaterialCategoriesController < Admin::BaseController
  def show
    @material_category = load_material_category

    @materials = @material_category.materials.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @material_category = MaterialCategory.new
  end

  def edit
    @material_category = load_material_category
  end

  def create
    @material_category = MaterialCategory.new(material_category_params)

    if @material_category.save
      redirect_to admin_material_category_path(@material_category), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @material_category = load_material_category

    if @material_category.update(material_category_params)
      redirect_to admin_material_category_path(@material_category), notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @material_category = load_material_category

    @material_category.materials.destroy_all

    @material_category.destroy

    redirect_to admin_price_admin_path, notice: "#{t :date_delete}"
  end

  private

  def load_material_category
    MaterialCategory.friendly.find(params[:id])
  end

  def material_category_params
    params.require(:material_category).permit(
      :name, 
      :name_ru,
      :name_en,
      :name_he,
      :color, 
      :size, 
      materials_attributes:[
        :id, 
        :name, 
        :name_ru,
        :name_en,
        :name_he, 
        :paper_format, 
        :price, 
        :price_opt, 
        :width, 
        :height, 
        :_destroy
      ]
    )
  end
end
