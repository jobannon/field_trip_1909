class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers 
  belongs_to :airline

  def number_minor
    binding.pry
    self.passengers.count.where('passenger.age < 18')
  end

  def number_adult
  end
end
