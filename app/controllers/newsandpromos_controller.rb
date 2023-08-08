class NewsandpromosController < BaseController
  def index
    @newsandpromos = Newsandpromo.published.order(created_at: :desc).page(params[:page]).per(9)

    set_seo(load_page_seo)
  end

  def show
    @newsandpromo = load_newsandpromo

    @recent_newsandpromos = load_recent_newsandpromos

    set_seo(@newsandpromo)
  end

  private

  def load_newsandpromo
    Newsandpromo.friendly.find(params[:id])
  end

  def load_recent_newsandpromos
    Newsandpromo.published.order(created_at: :desc).page(params[:page]).per(5)
  end

  def load_page_seo
    OpenStruct.new(seo_title: t('newsandpromos_page'), seo_description: t('newsandpromos_page_description'), image: '/favicon/ou.jpg')
  end
end
