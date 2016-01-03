class ConnectionsMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.connections_mailer.accept_friend_request.subject
  #
  def send_friend_request(recipient,sender)
    @sender = sender
    @recipient = recipient

    mail from: "#{@sender.full_name}<no-reply@apostell.com>",to: recipient.email, subject: "#{@recipient.first_name.capitalize!}, Add me to your Apostell Network"
  end

  def accept_friend_request(recipient,sender)
    @sender = sender
    @recipient = recipient

    mail from: "#{@sender.full_name}<no-reply@apostell.com>",to: recipient.email, subject: "You're now connected to #{@sender.first_name.capitalize!}"
  end
end
