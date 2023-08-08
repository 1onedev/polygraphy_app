class Ajax::ProductsController < ::Ajax::BaseController
  def show
    @product = Product.find(params[:id])

    if @product.brochure? || @product.magazine?
      @covers = ::Products::MaterialsQuery.new(@product).all
      @cover_colors    = ::Products::MaterialsQuery.new(@product, color: true).all
    else
    end
    if @product.etiketka?
      @sizes = ::Products::MaterialsQuery.new(@product, size: true).all
    else
    end
    @materials = ::Products::MaterialsQuery.new(@product).all
    @colors    = ::Products::MaterialsQuery.new(@product, color: true).all
  end
end
