class Api::V1::ConversationsController < ApplicationController
  before_filter :authenticate_user!

 
  layout false
 
  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.new(sender_id: params[:sender_id],recipient_id: params[:recipient_id])
      @conversation.save
    end
 
    render json: { conversation_id: @conversation.id }
  end
 
  def index
    @conversations = Conversation.where("(sender_id = ? or recipient_id = ?)", current_user.id, current_user.id)
  #   @reciever = interlocutor(@conversation)
  #   @messages = @conversation.messages
  #   @message = Message.new
  end
 
  private

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end