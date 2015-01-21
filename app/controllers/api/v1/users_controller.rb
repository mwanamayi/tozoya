class Api::V1::UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @users = User.new
  end

  def followers
    @followers = current_user.followers
  end

  def following
    @following = current_user.following_users
    respond_to do |format|
      format.html
      format.json { render :json => { :following => @following } }
    end
  end

  def follow
    @friend = User.find_by(username: params[:user][:username])
    redirect_to user_following_path unless current_user
    # if current_user
    # if current_user == @friend
    # flash[:error] = "You cannot follow yourself."
    # redirect_to user_following_path(current_user)
    # else
    current_user.follow(@friend)
    # flash[:notice] = "You are now following #{@friend.username}."
    redirect_to user_following_path(current_user)
    # end
    # end
  end

  def unfollow
    @friend = User.find_by(username: params[:user][:username])

    redirect_to user_following_path unless current_user
    # if current_user
    current_user.stop_following(@friend)
    flash[:notice] = "You are no longer following #{@friend.username}."
    redirect_to user_following_path(@user)
    # end
  end

  def update
    current_user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @user = User.where(id: params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => { :user => @user } }
    end
  end

  def profile
    p current_user
    p session[:user_id]
    @user = User.find(session[:user_id])
    render json: { :user => current_user }
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :email, :phone_number)
  end

end
