class FeedbacksController < ::BaseController
  layout false

  def create
    Feedback.create!(feedback_params)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :theme, :text)
  end
end