class InvitationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @event = Event.find(params[:event_id])
    @invitations = current_user.invitations
  end

  def create
    @event = Event.find(params[:event_id])
    @invitation = @event.invitations.build(params[:invitation])
  end

  def update
    @invitation = Invitation.where(event_id: params[:id], user_id: current_user.id).first
    @invitation.update(accepted: params[:accepted]).save
  end

  private

  def invitation_params
    @user = User.find_by(username: params[:invitation][:username])
    params[:invitation][:user_id] = @user.id
    params[:invitation][:status] = "pending"
    params.require(:invitation).permit(:user_id, :status)
  end
end
