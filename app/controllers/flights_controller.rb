class FlightsController < InheritedResources::Base

  def index
    flights = Flight.where(['date > ?', DateTime.now])
    filtered_flights =  []
    if flights.count > 0
      flights.each do |f|
        if current_user.friend?(f.user)
          filtered_flights << f
        elsif f.public?
          filtered_flights << f
        end
      end
      @flights = filtered_flights.present? ? filtered_flights.paginate(:page => params[:page]) : []
    else
      @flights = []
    end
  end
  

  def created_index
    @user = User.find(params[:user_id])
    created_flights = @user.flights
    if created_flights.count > 0
      @flights = created_flights.where(['date > ?', DateTime.now]).paginate(:page => params[:page])
    else
      @flights = []
    end

  end
end

