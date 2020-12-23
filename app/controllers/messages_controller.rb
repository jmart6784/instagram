class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    session[:return_to] ||= request.referer

    @messages = @conversation.messages.sort_by(&:created_at)

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_message
    if Message.find(params[:id]).user != current_user
      redirect_to session.delete(:return_to)
    end
  end
end
