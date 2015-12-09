class EventsController < ApplicationController
  skip_before_filter  :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    invited_events = @user.invited_events
    if invited_events.count > 0
      @invited_events =  invited_events.where(['start_date > ?', DateTime.now])
    else
      @invited_events = []
    end
  end

  def created_index
    @user = User.find(params[:user_id])
    created_events = @user.created_events
    if created_events.count > 0
      @events = created_events.where(['start_date > ?', DateTime.now])
    else
      @events = []
    end
  end

  def attending_index
    @user = User.find(params[:user_id])
    puts @user
    all_attending_events = @user.attending_events
    puts all_attending_events
    @events = []
    all_attending_events.each do |event|
      @events << event if event.start_date > DateTime.now
    end
    @events.sort! { |a,b| a.start_date <=> b.start_date }
    puts @events
  end

  def not_attending_index
    @user = User.find(params[:user_id])
    puts @user
    all_events = @user.invited_events
    puts all_events
    @events = []
    all_events.each do |event|
      @invitation = Invitation.where(event_id: event.id, user_id: @user.id).first
      if @invitation
        print @invitation
        @events << event if (event.start_date > DateTime.now) & (!@invitation.accepted?)
      end
    end
    @events.sort! { |a,b| a.start_date <=> b.start_date }
    puts @events
  end

 
  def attending_users_index
    @event = Event.find(params[:id])
    @confirmed_invitations = @event.invitations.where(accepted: true)
    @friends = []
    @confirmed_invitations.each do |invite|
      @attending_users << User.find(invite.user_id)
    end
    @users = @event.attending_users

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
