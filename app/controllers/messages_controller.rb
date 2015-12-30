class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token,
  :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter do
   @conversation = Conversation.find(params[:conversation_id])
 end

 def index
   @messages = @conversation.messages
   @messages.each do |m|
    puts m.inspect
  end

  # if @messages.length > 1000
  #  @over_ten = true
  #  @messages = @messages[-10..-1]
  # end

  # if params[:m]
  #  @over_ten = false
  #  @messages = @conversation.messages
  # end

  # if @messages.last
  # if @messages.last.user_id != current_user.id
   # @messages.last.read = true;
  # end
  puts "messages index"
  @message = @conversation.messages.new
end

def new
 @message = @conversation.messages.new
end

def create
 @message = @conversation.messages.create!(params[:message])
 if @message
  redirect_to conversation_messages_path(@conversation)

  content = @message.body
  message_sender = @message.user

  if @conversation.sender == message_sender
    recipient = @conversation.recipient
  elsif @conversation.sender != message_sender
    recipient = @conversation.sender
  end

  NewMessageMailer.new_message(recipient, message_sender, content).deliver
end
end

private
def message_params
  params.require(:message).permit(:body, :user_id)
end
end
