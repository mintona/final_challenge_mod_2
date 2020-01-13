require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a passenger's show page" do
    before :each do
      southwest = Airline.create(name: "Southwest")
      american = Airline.create(name: "American")

      @southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")

      @american_1 = american.flights.create(number: "AM1", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      @southwest_2 = southwest.flights.create(number: "SW2", date: "10/10/20", time: "0700", departure_city: "Denver", arrival_city: "New York")

      @passenger_1 = Passenger.create(name: "Alison Vermeil", age: 34)

      PassengerFlight.create(passenger: @passenger_1, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_1, flight: @american_1)
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

    it "I can fill in the form to add a flight by entering the flight number" do
      visit passenger_path(@passenger_1.id)

      within "#passenger-flights" do
        expect(page).to_not have_link(@southwest_2.number)
      end

      expect(page).to have_content("Add a Flight")

      within "#add-flight" do
        fill_in "Flight number", with: @southwest_2.number
        click_button "Submit"
      end

      expect(current_path).to eq(passenger_path(@passenger_1.id))

      within "#passenger-flights" do
        expect(page).to have_link(@southwest_2.number)
      end
    end
  end
end
