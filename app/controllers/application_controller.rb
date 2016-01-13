class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user
  before_filter :redirect_all_invites

  def set_current_user
    User.current = current_user
  end

  def route_name
    Rails.application.routes.router.recognize(request) do |route, _|
      return route.name.to_s
    end
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
    puts "route is:"
    puts route_name
    if ["new_user_registration","new_user_session"].include?(route_name)
      redirect_to root_path
    end
  end

end
