class Api::V1::InvitationsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    @invitations = current_user.invitations
  end

  def index_specific
    @invitation = Invitation.where(event_id: params[:event_id], 
                                  user_id: current_user.id).first 
  end

  def create
    @invitation = Invitation.create(params[:invitation])
    if @invitation.save
      @invitation
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => @invitation.errors.full_messages,
                        :data => {} }
    end
  end

  def accept
    @invitation = Invitation.where(event_id: params[:event_id], 
                                  user_id: current_user.id).first
    @invitation.accept!
  rescue ActiveRecord::RecordNotFound
    render :status => 404,
           :json => { :success => false,
                      :info => 'Not Found',
                      :data => {} }
  end

  def reject
    @invitation = Invitation.where(event_id: params[:event_id], 
                                  user_id: current_user.id).first
    @invitation.reject!
  rescue ActiveRecord::RecordNotFound
    render :status => 404,
           :json => { :success => false,
                      :info => 'Not Found',
                      :data => {} }
  end
end
