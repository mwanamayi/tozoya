class NewMessageMailer < ActionMailer::Base
  default sender: "no-reply@apostell.com"

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

    mail to: recipient.email, subject: "Apostell Messaging"
  
  end
end
