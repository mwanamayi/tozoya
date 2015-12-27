class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    print "auth controller"
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    print "auth controller 2"
    if @user.present? || @user.save
      debugger
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      @user.update_facebook_pic(request.env["omniauth.auth"].info.image)
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end