class FlightsController < ApplicationController
  def show
    @flight = Flight.find(params[:id])
  end

  def create 
    our_passenger = Passenger.find(passenger_flight_params[:id])
    our_flight_to_add = Flight.where(number: passenger_flight_params[:flight_num])
    our_passenger.flights << our_flight_to_add
    redirect_to "/passengers/#{our_passenger.id}"
  end 

  private

  def passenger_flight_params
    params.permit(:id, :flight_num)
  end
end
