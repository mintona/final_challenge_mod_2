class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
  end

  def update
    passenger = Passenger.find(params[:id])
    flight = Flight.find_by(number: params[:flight_number])
    flight.passengers << passenger

    redirect_to passenger_path(params[:id])
  end
end
