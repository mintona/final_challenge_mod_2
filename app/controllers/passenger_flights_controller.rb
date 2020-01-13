class PassengerFlightsController < ApplicationController
  def update
    passenger = Passenger.find(params[:passenger_id])
    flight = Flight.find_by(number: params[:flight_number])

    PassengerFlight.create(passenger: passenger, flight: flight)

    redirect_to passenger_path(params[:passenger_id])
  end
end
