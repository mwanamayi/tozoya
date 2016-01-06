class NewMessageMailer < ActionMailer::Base
  require 'digest/sha2' 
default "Message-ID" => lambda {"<#{SecureRandom.uuid}@apostell.com>"}

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_message_mailer.new_message.subject
  #
  def new_message(recipient,sender,content,conversation)

    @sender = sender
    @recipient = recipient
    @content = content
    @conversation = conversation

    mail from: "Apostell Messaging <no-reply@apostell.com>",to: @recipient.email, subject: "#{sender.full_name} sent you a message"
  
  end
end
