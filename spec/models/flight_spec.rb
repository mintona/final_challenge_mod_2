require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end

  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through(:passenger_flights)}
  end

  describe 'model methods' do
    before :each do
      southwest = Airline.create(name: "Southwest")

      @southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")

      @passenger_1 = Passenger.create(name: "Alison Vermeil", age: 34)
      @passenger_2 = Passenger.create(name: "Emily Beardlsey", age: 17)
      @passenger_3 = Passenger.create(name: "Jack Beardlsey", age: 4)
      @passenger_4 = Passenger.create(name: "Alex Minton", age: 18)

      PassengerFlight.create(passenger: @passenger_1, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_2, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_3, flight: @southwest_1)
      PassengerFlight.create(passenger: @passenger_4, flight: @southwest_1)
    end

    describe '#number_of_minors' do
      it 'calculates the number of passengers who are less than 18 years old' do
        expect(@southwest_1.number_of_minors).to eq(2)
      end
    end
  end
end
