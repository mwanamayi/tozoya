class FlightsController < InheritedResources::Base

  def index
    flights = Flight.where(['date > ?', DateTime.now])
    filtered_flights =  []
    if flights.count > 0
      flights.each do |r|
        if current_user.friend?(r.user)
          filtered_flights << r
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

