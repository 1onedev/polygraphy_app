class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.order(created_at: :desc).page(params[:page]).per(10)

    Feedback.unviewed.update_all(viewed: true)
  end

  def destroy
    @feedback = load_feedback

    @feedback.destroy

    redirect_to admin_feedbacks_path, notice: "#{t :date_delete}"
  end

  private

  def load_feedback
    Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :theme, :text)
  end
end