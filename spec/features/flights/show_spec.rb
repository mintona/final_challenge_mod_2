require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a flight's show page" do
    before :each do
      southwest = Airline.create(name: "Southwest")
      american = Airline.create(name: "American")

      @southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @american_1 = american.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      @passenger_1 = Passenger.create(name: "Alison Vermeil", age: 34)
      @passenger_2 = Passenger.create(name: "Emily Beardlsey", age: 32)
      @passenger_3 = Passenger.create(name: "Jack Beardlsey", age: 4)
      @passenger_4 = Passenger.create(name: "Rick Vermeil", age: 34)

      PassengerFlight.create(passenger: @passenger_1, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_2, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_3, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_4, flight: @american_1)
    end

    it "I see that flights information and airline" do
      visit flight_path(@southwest_1)

      expect(page).to have_content("Number: #{@southwest_1.number}")
      expect(page).to have_content("Date: #{@southwest_1.date}")
      expect(page).to have_content("Time: #{@southwest_1.time}")
      expect(page).to have_content("Departure City: #{@southwest_1.departure_city}")
      expect(page).to have_content("Arrival City: #{@southwest_1.arrival_city}")

      expect(page).to have_content("Airline: #{@southwest_1.airline.name}")

      expect(page).to_not have_content(@american_1.number)
      expect(page).to_not have_content(@american_1.date)
      expect(page).to_not have_content(@american_1.time)
      expect(page).to_not have_content(@american_1.departure_city)
      expect(page).to_not have_content(@american_1.arrival_city)
      expect(page).to_not have_content(@american_1.airline.name)
    end

    it "I see the names of all passengers on the flight" do
      visit flight_path(@southwest_1)

      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to have_content(@passenger_3.name)
      expect(page).to_not have_content(@passenger_4.name)
    end
  end
end
