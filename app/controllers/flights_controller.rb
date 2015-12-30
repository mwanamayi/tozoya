class FlightsController < InheritedResources::Base
  require 'will_paginate/array'
  skip_before_filter  :verify_authenticity_token

before_filter :authenticate_user!

  def index
    @flights = Flight.filter(params).paginate(:page => params[:page])

      respond_to do |format|
        format.html
        format.js #-> loads /views/flights/index.js.erb
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

