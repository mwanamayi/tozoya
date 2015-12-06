class EventsController < ApplicationController
  skip_before_filter  :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  def index
    invited_events = current_user.invited_events
    if invited_events.count > 0
      @invited_events =  invited_events.where(['datetime > ?', DateTime.now])
    else
      @invited_events = []
    end
  end

  def created_index
    created_events = current_user.created_events
    if created_events.count > 0
      @created_events = created_events.where(['datetime > ?', DateTime.now])
    else
      @created_events = []
    end
  end

  def attending_index
    all_attending_events = current_user.attending_events
    @attending_events = []
    all_attending_events.each do |event|
      @attending_events << event if event.datetime > DateTime.now
    end
    @attending_events.sort! { |a,b| a.datetime <=> b.datetime }
  end

 
  def attending_users_index
    @event = Event.find(params[:id])
    @confirmed_invitations = @event.invitations.where(accepted: true)
    @friends = []
    @confirmed_invitations.each do |invite|
      @attending_users << User.find(invite.user_id)
    end
    # @users = @event.attending_users

    respond_to do |format|
      format.html
      format.json { render :json => { :friends => @friends } }
    end
  end

  def create
    @event = current_user.created_events.build(params[:event])
    if @event.save
      @event
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => @event.errors.full_messages,
                        :data => {} }
    end
  end


end
