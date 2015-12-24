class RequestsController < InheritedResources::Base
  require 'will_paginate/array'

  def index
    requests = Request.where(['date > ?', DateTime.now])
    filtered_requests =  []
    if requests.count > 0
      requests.each do |r|
        if current_user.friend?(r.user)
          filtered_requests << r
        elsif r.public?
          filtered_requests << r
        end
      end
      @requests = filtered_requests.present? ? filtered_requests.paginate(:page => params[:page]) : []
    else
      @requests = []
    end
  end
  

  def created_index
    @user = User.find(params[:user_id])
    created_requests = @user.requests
    if created_requests.count > 0
      @requests = created_requests.where(['date > ?', DateTime.now]).paginate(:page => params[:page])
    else
      @requests = []
    end

  end
end

