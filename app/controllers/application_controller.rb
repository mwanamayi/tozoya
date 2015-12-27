class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  def set_current_user
    User.current = current_user
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :notice => "Oops! Looks like you haven't signed in yet!"
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

end
