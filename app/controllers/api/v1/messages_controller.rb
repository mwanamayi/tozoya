class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end
   
  def create
    @conversation = Conversation.find(params[:id])
    @message = @conversation.messages.build(params)
    @message.user_id = current_user.id
    @message.save!
 
    @path = conversation_path(@conversation)
  end

end