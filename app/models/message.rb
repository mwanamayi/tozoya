class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  attr_accessible :body, :conversation_id, :user_id

  after_create :update_conversation_timestamp
 
  validates_presence_of :conversation_id, :user_id


  default_scope order('updated_at ASC')

  def find_sender
    @sender = User.find(self.user_id)
  end

  def sender_avatar
    find_sender
    @sender_avatar = @sender.avatar
  end

  def update_conversation_timestamp
    conversation = self.conversation
    conversation.updated_at = self.created_at
    conversation.save
  end

  def formatted_updated_at
    self.updated_at.strftime('%b %d %Y, %H:%M%p')
  end

  def sender_username
    find_sender
    @sender_username = @sender.username
  end

  def message_time
    self.created_at.strftime('%m/%d/%y' + "at" + '%l:%M %p')
  end

  def formatted_updated_at
    # self.datetime.strftime('%a, %b %d, %I:%M%p')
    self.updated_at.strftime('%I:%M%p')
  end
end