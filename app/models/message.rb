class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  attr_accessible :body, :conversation_id, :user_id

  after_create :update_conversation_timestamp
 
  validates_presence_of :conversation_id, :user_id


  default_scope order('updated_at ASC')

  def sender
    @sender = User.find(self.user_id)
  end

  def sender_avatar
    sender
    @sender_avatar = @sender.avatar
  end

  def update_conversation_timestamp
    conversation = self.conversation
    conversation.updated_at = self.created_at
    conversation.save
  end

  def formatted_updated_at
    if updated_at == Date.today
      self.updated_at.strftime('%I:%M%p')
    elsif ((Date.today - 7)..(Date.today)).include?(updated_at.strftime('%a, %d %b %Y').to_date)
      self.updated_at.strftime('%A, %I:%M%p')
    else
      self.updated_at.strftime('%a, %b %d, %I:%M%p')
    end
    # self.updated_at.strftime('%I:%M%p')
  end

  def sender_username
    sender
    @sender_username = @sender.username
  end

  def message_time
    self.created_at.strftime('%m/%d/%y' + "at" + '%l:%M %p')
  end
end