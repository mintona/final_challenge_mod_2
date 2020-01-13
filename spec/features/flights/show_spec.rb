require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a flight's show page" do
    before :each do
      southwest = Airline.create(name: "Southwest")
      american = Airline.create(name: "American")

      @southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @american_1 = american.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

    end

    it "I see that flights information and airline" do
      visit flight_path(@southwest_1)

      expect(page).to have_content(@southwest_1.number)
      expect(page).to have_content(@southwest_1.date)
      expect(page).to have_content(@southwest_1.time)
      expect(page).to have_content(@southwest_1.departure_city)
      expect(page).to have_content(@southwest_1.arrival_city)

      expect(page).to have_content("Airline: #{@southwest_1.airline.name}")
    end

    xit "I see the names of all passengers on the flight" do

    end
  end
end
