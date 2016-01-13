class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

 
  def index
    @user = current_user
    @users = User.all
    @conversations = []
    @all_conversations = Conversation.where("(sender_id = ? or recipient_id = ?)", current_user.id, current_user.id)

    @all_conversations.each do |c|
      if c.messages.present?
        @conversations << c
      end
    end
  #   @reciever = interlocutor(@conversation)
  #   @messages = @conversation.messages
    @message = Message.new
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      puts params[:sender_id]
      puts params[:recipient_id]
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.new(sender_id: params[:sender_id],recipient_id: params[:recipient_id])
      @conversation.save
    end

    redirect_to conversation_messages_path(@conversation)
  end
 
  private
  
 def conversation_params
  params.permit(:sender_id, :recipient_id)
 end
end