class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:destroy]

  def index
    @conversations = current_user.sender_conversations + current_user.receiver_conversations
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    flash.notice = "Conversation was deleted!"
    redirect_to conversations_path
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def set_conversation
    convo = Conversation.find(params[:id])
    sender = convo.sender
    recipient = convo.recipient

    unless current_user === sender || current_user === recipient
      redirect_to conversations_path
    end
  end
end
