class RequestsController < InheritedResources::Base
  require 'will_paginate/array'
  skip_before_filter  :verify_authenticity_token

before_filter :authenticate_user!

  def index
    @requests = Request.filter(params)
    @search = params[:search]
      respond_to do |format|
        format.html
        format.js #-> loads /views/requests/index.js.erb
      end
  end
  

  def created_index
    @user = current_user
    created_requests = @user.requests
    if created_requests.count > 0
      @requests = created_requests.where(['date > ?', DateTime.now]).paginate(:page => params[:page])
    else
      @requests = []
    end

  end

  # private

  # def request_params
  #   params.require(:user).permit(:content, :date, :departure, :destination, :picture, :public, :latitude, :longitude)
  # end
end

