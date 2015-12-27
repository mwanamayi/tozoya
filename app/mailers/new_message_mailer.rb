class NewMessageMailer < ActionMailer::Base
  default from: "no-reply@apostell.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_message_mailer.new_message.subject
  #
  def new_message(recipient,sender)

    @sender = sender
    @recipient = recipient

    mail to: recipient.email, subject: "Apostell: New Message from #{sender.full_name}!"
  
  end
end
