class User::MessagesController < ::User::BaseController
  def index
    @messages = Message.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(10)

    Message.unviewed.update_all(viewed: true)
  end
  
  def create
    message = Message.new(message_params)

    if message.save
      redirect_to user_messages_path
    else
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user: current_user)
  end
end