# As a visitor
# When I visit a flights show page ('/flights/:id')
# I see all of that flights information including:
#   - number
#   - date
#   - time
#   - departure city
#   - arrival city
# And I see the name of the airline this flight belongs
# And I see the names of all of the passengers on this flight
require 'rails_helper'

RSpec.describe "Flight Show Spec" do
  describe "When I visit the flight show page" do
    before(:each) do 
      @southwest = Airline.create(name: "Southwest")

      @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
      @passenger_1 = Passenger.create!(name: "sue", age: 15)
      @passenger_2 = Passenger.create!(name: "bob", age: 30)
      @southwest_1.passengers << @passenger_1
      @southwest_1.passengers << @passenger_2 
    end
    it "I see all of that flights information including: 
        - number
        - date
        - time
        - departure city
        - arrival city
        - And I see the name of the airline this flight belongs
        - And I see the names of all of the passengers on this flight" do

        visit "/flights/#{@southwest_1.id}"
       
        expect(page).to have_content(@southwest_1.number)
        expect(page).to have_content(@southwest_1.date)
        expect(page).to have_content(@southwest_1.time)
        expect(page).to have_content(@southwest_1.departure_city)
        expect(page).to have_content(@southwest_1.arrival_city)

        expect(page).to have_content(@southwest_1.airline.name)
        expect(page).to have_content(@southwest_1.passengers[0].name)
        expect(page).to have_content(@southwest_1.passengers[1].name)
    end
  end
end
