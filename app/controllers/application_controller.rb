class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  def set_current_user
    User.current = current_user
  end

  def after_sign_in_path_for(resource_or_scope)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
