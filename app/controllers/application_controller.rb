class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user
  before_filter :redirect_all_invites

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

  def redirect_all_invites
    if request.original_url == ("http://localhost:3000/users/sign_up" || "https://localhost:3000/users/sign_up" || "http://apostell.com/users/sign_up" || "https://apostell.com/users/sign_up" || "http://apostell.com/users/sign_up" )
      redirect_to root_path
    end
  end

end
