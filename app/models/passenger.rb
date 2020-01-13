class Passenger < ApplicationRecord
  validates_presence_of :name, :age
  validates_numericality_of :age, greater_than: 0

  has_many :passenger_flights
  has_many :flights, through: :passenger_flights
end
