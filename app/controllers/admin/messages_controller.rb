class Admin::MessagesController < Admin::BaseController
  def index
    @user = User.find_by(id: params[:user_id])

    if @user
      @messages = Message.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(10)
    else
      @messages = Message.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def create
    message = Message.new(message_params)

    if message.save
      redirect_to admin_messages_path(user_id: message.user_id)
    else
    end

    user = User.find_by(id: message.user_id)
    if user.messages.count > 50
      user.messages.order(created_at: :desc).offset(50).delete_all
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :user_id).merge(admin: current_admin)
  end
end