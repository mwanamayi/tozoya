class Api::V1::MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

 
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
 
    @path = conversation_path(@conversation)
  end
 
  private
 
  def message_params
    params.require(:message).permit(:body)
  end
end