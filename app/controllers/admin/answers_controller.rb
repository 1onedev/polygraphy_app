class Admin::AnswersController < Admin::BaseController
  def index
    @answers = Answer.order(position: :asc).page(params[:page]).per(10)
  end

  def new
    @answer = Answer.new
  end

  def edit
    @answer = load_answer
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to admin_answers_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def update
    @answer = load_answer

    if @answer.update(answer_params)
      redirect_to admin_answers_path, notice: "#{t :date_save}"
    else
      alert = { error: "#{t :date_error}" }

      render :edit
    end
  end

  def destroy
    @answer = load_answer

    @answer.destroy

    redirect_to admin_answers_path, notice: "#{t :date_delete}"
  end

  private

  def load_answer
    Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(
      :position, 
      :question, 
      :question_ru, 
      :question_en, 
      :question_he, 
      :text, 
      :text_ru,
      :text_en,
      :text_he
    )
  end
end
