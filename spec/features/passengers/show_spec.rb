# ser Story 3, Assign a Passenger to a Flight

# As a visitor
# When I visit a passengers show page
# I see a form to add a flight
# When I fill in the form with a flight number (assuming these will always be unique)
# And click submit
# I'm taken back to the passengers show page
# And I can see the flight number of the flight I just addedl

require 'rails_helper'

RSpec.describe "Passenger Show Spec" do
  describe "When I visit the Passengers show page" do
    before(:each) do 
      @southwest = Airline.create(name: "Southwest")

      @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
      @southwest_3 = @southwest.flights.create(number: "SW3", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      @passenger_1 = Passenger.create!(name: "sue", age: 15)
      @southwest_1.passengers << @passenger_1
      @southwest_2.passengers << @passenger_1 
    end

    it "-I see that passengers name
        -And I see a section of the page that displays all flight numbers of the flights for that passenger
        -And all flight numbers listed link to that flights show page" do 

      visit "passengers/#{@passenger_1.id}"

      expect(page).to have_content(@passenger_1.name)

      within "#passenger_flights" do 
        expect(page).to have_content(@passenger_1.flights[0].id)
        expect(page).to have_content(@passenger_1.flights[1].id)
        click_link "#{@passenger_1.flights[0].id}"
      end

      expect(current_path).to eq("/flights/#{@southwest_1.id}")
       
    end

   it "I see a form to add a flight
      - When I fill in the form with a flight number (assuming these will always be unique)
      - And click submit
      - I'm taken back to the passengers show page
      - And I can see the flight number of the flight I just added" do

      visit "passengers/#{@passenger_1.id}"

      within "#passenger_flights_add" do 
        fill_in :flight_num, with: "SW3" 
        click_button "Add Flight"
      end
      

      within "#passenger_flights" do 
        expect(page).to have_content(@passenger_1.flights[2].id)
      end 

    end
  end
end 

