class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city

  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def number_of_minors
    passengers.where("age < 18").count
  end

  def number_of_adults
    passengers.where("age >= 18").count
  end
end
