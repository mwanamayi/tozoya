class FlightsController < InheritedResources::Base

  def created_index
    @user = User.find(params[:user_id])
    created_flights = @user.flights
    if created_flights.count > 0
      @flights = created_flights.where(['departure > ?', DateTime.now])
    else
      @flights = []
    end

  end
end

