require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a passenger's show page" do
    before :each do
      southwest = Airline.create(name: "Southwest")
      american = Airline.create(name: "American")

      @southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @american_1 = american.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      @passenger_1 = Passenger.create(name: "Alison Vermeil", age: 34)
      # @passenger_2 = Passenger.create(name: "Emily Beardlsey", age: 32)
      # @passenger_3 = Passenger.create(name: "Jack Beardlsey", age: 4)
      # @passenger_4 = Passenger.create(name: "Rick Vermeil", age: 34)

      PassengerFlight.create(passenger: @passenger_1, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_1, flight: @american_1)
      # PassengerFlight.create(passenger: @passenger_3, flight: @southwest_1)
      # PassengerFlight.create(passenger: @passenger_4, flight: @american_1)
    end

    it "I see that passengers name" do
      visit passenger_path(@passenger_1.id)

      expect(page).to have_content(@passenger_1.name)
    end

    it "I see the flight numbers of flights that passenger has taken as links to that flights show page" do
      visit passenger_path(@passenger_1.id)

      within("#passenger-flights") do
        expect(page).to have_link(@southwest_1.number)
        expect(page).to have_link(@american_1.number)
        click_link (@american_1.number)
      end

      expect(current_path).to eq(flight_path(@american_1.id))
    end
  end
end
