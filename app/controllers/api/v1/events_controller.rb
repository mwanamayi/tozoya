class Api::V1::EventsController < ApplicationController
  skip_before_filter  :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  def index
    @invited_events = current_user.invited_events

  end

  def created_index
    @created_events = current_user.created_events.where(['datetime > ?', DateTime.now])
  end

  def attending_index
    @attending_events = current_user.attending_events
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
