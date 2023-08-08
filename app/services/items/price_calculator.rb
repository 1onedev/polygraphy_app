module Items
  class PriceCalculator
    attr_accessor :paper_price, :color_price, :time_price, :podborka, :scoba, :stitching_price,
                  :falcovka, :cover_price, :cover_color_price, :lamination_price,
                  :paper_lak, :items_per_paper, :form_price, :all_paper_price, :form_color_price

    def initialize(current_user = nil, params = {})
      @current_user = current_user
      @params = params.delete_if { |_param, value| value.blank? }.with_indifferent_access
    end

    def call
      begin
        if product.product_category.ctp?
          if @current_user.present? && @current_user.opt_price?
            #калькулятор для ctp оптовый
            (((material_color.price * product_circulation.count.to_f) * opt_discount) / 100).ceil
          else
            #калькулятор для ctp обычный 
            material_color.price * product_circulation.count.to_f
          end
        else
          if @current_user.present? && @current_user.opt_price?
            #оптовый калькулятор
            if product.a2?
              #лист А2
              case 
              when product.brochure?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((594 * 420) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @scoba = (product_circulation.count.to_f * scoba_price).floor
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (((@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @scoba) * opt_discount) / 100).ceil
                else
                  (((material_color.price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              when product.magazine?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((594 * 420) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @falcovka =  (@page_count * falcovka_price).floor
                  @stitching_price = stitching_type
                  @lamination_price = lamination_price_set
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (((@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @falcovka + @stitching_price + @lamination_price) * opt_discount) / 100).ceil
                else
                  (((material_color.price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              when product.etiketka?
                if material_base.present?
                  @all_paper_price = material_base.price * (product_circulation.count.to_f + calculation_variable)
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = etiketka_color_price
                  @paper_lak = paper_lak_price

                  (((@all_paper_price + @time_price + @color_price + (material_color.price * 1) + @paper_lak) * opt_discount) / 100).ceil
                else
                  (@time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                end
              when product.standart?
                if material_base.present?
                  @items_per_paper = ((594 * 420) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @form_color_price = material_color_price

                  (((@paper_price + @color_price + @form_color_price + @time_price) * opt_discount) / 100).ceil
                else
                  (((@form_color_price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              else
                if material_base.present?
                  @items_per_paper = ((594 * 420) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @form_color_price = material_color_price

                  (((@paper_price + @color_price + @form_color_price + @time_price) * opt_discount) / 100).ceil
                else
                  (((@form_color_price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              end
            else
              #лист B2
              case
              when product.brochure?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((707 * 500) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @scoba = (product_circulation.count.to_f * scoba_price).floor
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (((@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @scoba) * opt_discount) / 100).ceil
                else
                  (((material_color.price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              when product.magazine?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((707 * 500) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @falcovka =  (@page_count * falcovka_price).floor
                  @stitching_price = stitching_type
                  @lamination_price = lamination_price_set
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (((@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @falcovka + @stitching_price + @lamination_price) * opt_discount) / 100).ceil
                else
                  (((material_color.price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              when product.etiketka?
                if material_base.present?
                  @all_paper_price = material_base.price * (product_circulation.count.to_f + calculation_variable)
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = etiketka_color_price
                  @paper_lak = paper_lak_price

                  (((@all_paper_price + @time_price + @color_price + (material_color.price * 1) + @paper_lak) * opt_discount) / 100).ceil
                else
                  (@time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                end
              when product.standart?
                if material_base.present?
                  @items_per_paper = ((707 * 500) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @form_color_price = material_color_price

                  (((@paper_price + @color_price + @form_color_price + @time_price) * opt_discount) / 100).ceil
                else
                  (((@form_color_price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              else
                if material_base.present?
                  @items_per_paper = ((707 * 500) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @form_color_price = material_color_price

                  (((@paper_price + @color_price + @form_color_price + @time_price) * opt_discount) / 100).ceil
                else
                  (((@form_color_price * product_circulation.count.to_f) * opt_discount) / 100).ceil
                end
              end
            end
          else
            #стандартный калькулятор
            if product.a2?
              #лист A2
              case
              when product.brochure?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((594 * 420) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @scoba = (product_circulation.count.to_f * scoba_price).floor
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @scoba).ceil
                else
                  (material_color.price * product_circulation.count.to_f).ceil
                end
              when product.magazine?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((594 * 420) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @falcovka =  (@page_count * falcovka_price).floor
                  @stitching_price = stitching_type
                  @lamination_price = lamination_price_set
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @falcovka + @stitching_price + @lamination_price).ceil
                else
                  (material_color.price * product_circulation.count.to_f).ceil
                end
              when product.etiketka?
                if material_base.present?
                  @all_paper_price = material_base.price * (product_circulation.count.to_f + calculation_variable)
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = etiketka_color_price
                  @paper_lak = paper_lak_price

                  (@all_paper_price + @time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                else
                  (@time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                end
              when product.standart?
                if material_base.present?
                  @items_per_paper = ((594 * 420) / (product.width * product.height).to_f).floor 
                  page_count_without_variable  = (product_circulation.count.to_f / @items_per_paper.to_f).ceil
                  @page_count =  (page_count_without_variable + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @form_color_price = material_color_price

                  (@paper_price + @color_price + @form_color_price + @time_price).ceil
                else
                  (@form_color_price * product_circulation.count.to_f).ceil
                end
              else
                if material_base.present?
                  @items_per_paper = ((594 * 420) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper) * paint_price
                  @form_color_price = material_color_price

                  (@paper_price + @color_price + @form_color_price + @time_price).ceil
                else
                  (@form_color_price * product_circulation.count.to_f).ceil
                end
              end
            else
              #лист B2
              case
              when product.brochure?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((707 * 500) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @scoba = (product_circulation.count.to_f * scoba_price).floor
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @scoba).ceil
                else
                  (material_color.price * product_circulation.count.to_f).ceil
                end
              when product.magazine?
                if material_base.present? && material_cover.present?
                  @items_per_paper = (((707 * 500) / (product.width * product.height).to_f) * 2).floor #items_per_paper & cover_per_paper
                  @page_count_without_variable = ((page_circulation.count.to_f / @items_per_paper.to_f) * product_circulation.count.to_f).ceil
                  @page_count     =  (@page_count_without_variable + calculation_variable_for_sborka).ceil
                  @cover_count    = ((((4).to_f / @items_per_paper.to_f) * product_circulation.count.to_f) + calculation_variable_for_cover).ceil
                  @paper_price     = @page_count * material_base.price
                  @cover_price     = @cover_count * material_cover.price
                  @time_price      = ((((time_to_one_color * form_sum) * (page_circulation.count.to_f / @items_per_paper.to_f)).to_f / 60) + (((time_to_one_color * form_sum_for_cover) * 1).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @podborka =  (@page_count * podborka_price).floor
                  @falcovka =  (@page_count * falcovka_price).floor
                  @stitching_price = stitching_type
                  @lamination_price = lamination_price_set
                  @form_price = material_color.price * (page_circulation.count.to_f / @items_per_paper.to_f)

                  (@paper_price + @cover_price + @color_price + (material_cover_color.price * 1) + @form_price + @time_price + @podborka + @falcovka + @stitching_price + @lamination_price).ceil
                else
                  (material_color.price * product_circulation.count.to_f).ceil
                end
              when product.etiketka?
                if material_base.present?
                  @all_paper_price = material_base.price * (product_circulation.count.to_f + calculation_variable)
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = etiketka_color_price
                  @paper_lak = paper_lak_price

                  (@all_paper_price + @time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                else
                  (@time_price + @color_price + (material_color.price * 1) + @paper_lak).ceil
                end
              when product.standart?
                if material_base.present?
                  @items_per_paper = ((707 * 500) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @form_color_price = material_color_price

                  (@paper_price + @color_price + @form_color_price + @time_price).ceil
                else
                  (@form_color_price * product_circulation.count.to_f).ceil
                end
              else
                if material_base.present?
                  @items_per_paper = ((707 * 500) / (product.width * product.height).to_f).floor 
                  @page_count     = ((product_circulation.count.to_f / @items_per_paper.to_f) + calculation_variable).ceil
                  @paper_price     = @page_count * material_base.price
                  @time_price      = (((time_to_one_color * form_sum).to_f / 60) + (page_count_for_2.to_f / print_speed.to_f)) * work_price
                  @color_price     = ((page_count_for_2.to_f / (1000).to_f) * paint_per_paper_b2) * paint_price
                  @form_color_price = material_color_price

                  (@paper_price + @color_price + @form_color_price + @time_price).ceil
                else
                  (@form_color_price* product_circulation.count.to_f).ceil
                end
              end
            end
          end
        end
      rescue => e
        product.price
      end
    end

    private

    def print_price
      # цена запечатки
      calculation_settings.print_price
    end

    def time_to_one_color
      # время на форму
      calculation_settings.time_to_one_color
    end

    def print_speed
      # скорость печати
      calculation_settings.print_speed
    end

    def work_price
      # цена работы
      calculation_settings.work_price
    end

    def lamination_price_set
      # стоимость ламинации
      if @params[:lamination].present? && @params[:lamination] == 'with_lamination'
        (@cover_count * calculation_settings.lamination_price).ceil
      else
        0
      end
    end

    def paper_lak_price
      if @params[:lak].present? && @params[:lak] == 'with_lak'
        consumption_lak = (((material_size.width.to_i * material_size.height.to_i) * 0.3) / (600 * 900)).to_f
        consumption_lak_all = (product_circulation.count.to_f / 1000) * consumption_lak
        (consumption_lak_all * calculation_settings.lak_price).ceil
      else
        0
      end
    end

    def etiketka_color_price
      consumption_color = (((material_size.width.to_i * material_size.height.to_i) * 0.5) / (600 * 900)).to_f
      consumption_color_all = (product_circulation.count.to_f / 1000) * consumption_color
      (consumption_color_all * calculation_settings.paint_price).ceil
    end

    def form_sum
      # количество форм
      if @params[:oborot].present? && @params[:oborot] == 'self'
        if material_color.width.to_i.zero? || material_color.height.to_i.zero?
          material_color.width.to_i + material_color.height.to_i
        else
          ((material_color.width.to_i + material_color.height.to_i) / 2).ceil
        end
      else
        material_color.width.to_i + material_color.height.to_i
      end
    end

    def material_color_price
      if @params[:oborot].present? && @params[:oborot] == 'self'
        if material_color.width.to_i.zero? || material_color.height.to_i.zero?
          material_color.price
        else
          @materials = Material.where(height: 0, width: form_sum).all
          @materials.first.price
        end
      else
        material_color.price
      end
    end

    def form_sum_for_cover
      # количество форм
      material_cover_color.width.to_i + material_cover_color.height.to_i
    end

    def stitching_type
      # выбор сшивки для журнала
      if @params[:stitching].present? && @params[:stitching] == 'scoba'
        (product_circulation.count.to_f * scoba_price).floor
      else
        (product_circulation.count.to_f * skleyka_price).floor
      end
    end

    def opt_discount
      # оптовая скидка
      100 - calculation_settings.opt_discount
    end

    def page_count_for_2
      # Время работы на двойной или одинарный прогон
      case
      when material_color.width.to_i.zero? || material_color.height.to_i.zero?
        case
        when product.brochure? || product.magazine?
          (@page_count * 1) + (@cover_count * 1)
        when product.etiketka?
          product_circulation.count.to_f + calculation_variable
        else
          @page_count * 1
        end
      else
        case
        when product.brochure? || product.magazine?
          (@page_count * 2) + (@cover_count * 2)
        when product.etiketka?
          product_circulation.count.to_f * 2
        else
          @page_count * 2
        end
      end
    end

    def calculation_variable_for_sborka
      # Приладка
      if material_cover.present? && (@page_count_without_variable > 1001)
        (((@page_count_without_variable.to_f / 1000.to_f) * form_sum) * calculation_settings.calculation_variable).ceil
      else
        form_sum * calculation_settings.calculation_variable
      end
    end

    def calculation_variable
      form_sum * calculation_settings.calculation_variable
    end

    def calculation_variable_for_cover
      form_sum_for_cover * calculation_settings.calculation_variable
    end

    def paint_price
      # цена одного кг краски
      calculation_settings.paint_price
    end

    def paint_per_paper
      # колово кг краски на 1000 листов
      calculation_settings.paint_per_paper
    end

    def paint_per_paper_b2
      # колово кг краски на 1000 листов B2 формата
      ((70.7 * 50 * 1000).to_f * calculation_settings.paint_per_paper.to_f) / (64 * 45 * 1000).to_f 
    end

    def podborka_price
      calculation_settings.podborka_price
    end

    def scoba_price
      calculation_settings.scoba_price
    end

    def skleyka_price
      calculation_settings.skleyka_price
      # 1000 книг + 70 обложек
    end

    def falcovka_price
      case
      when (product.width * product.height) == (148 * 210) || (product.width * product.height) == (176 * 250)
        3 * calculation_settings.falcovka_price
        #на 1000 листов + 20 листов 
      when (product.width * product.height) == (210 * 297) || (product.width * product.height) == (257 * 364)
        2 * calculation_settings.falcovka_price
      else
        2 * calculation_settings.falcovka_price
      end
    end

    def material_base
      @material_base ||= Material.find_by(id: @params[:material_base_id])
    end

    def material_color
      @material_color ||= Material.find_by(id: @params[:material_color_id])
    end

    def material_cover
      @material_cover ||= Material.find_by(id: @params[:material_cover_id])
    end

    def material_cover_color
      @material_cover_color ||= Material.find_by(id: @params[:material_cover_color_id])
    end

    def material_size
      @material_size ||= Material.find_by(id: @params[:material_size_id])
    end

    def page_circulation
      @page_circulation ||= 
        (PageCirculation.find_by(id: @params[:page_circulation_id]) || OpenStruct.new(count: @params[:page_circulation]))
    end

    def product_circulation
      @product_circulation ||= 
        (ProductCirculation.find_by(id: @params[:product_circulation_id]) || OpenStruct.new(count: @params[:product_circulation]))
    end

    def product
      @product ||= Product.find_by(id: @params[:product_id]) || product_circulation.product
    end

    def calculation_settings
      @calculation_settings ||= CalculationSetting.instance
    end
  end
end
