class RequestsController < InheritedResources::Base

  def index
    requests = Request.where(['date > ?', DateTime.now])
    if requests.count > 0
      @requests = requests.paginate(:page => params[:page])
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

