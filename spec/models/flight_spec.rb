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
    it {should have_many(:flight_passengers) }
    it {should have_many(:passengers).through(:flight_passengers) }
  end
  describe "instance methods" do 
    it "number_minor" do 
      @southwest = Airline.create(name: "Southwest")

      @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @passenger_1 = Passenger.create!(name: "sue", age: 15)
      @passenger_2 = Passenger.create!(name: "bob", age: 30)
      @southwest_1.passengers << @passenger_1
      @southwest_1.passengers << @passenger_2 

      expect(@southwest_1.number_minor).to eq(1)
    end
    it "number_adult" do
      @southwest = Airline.create(name: "Southwest")

      @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @passenger_1 = Passenger.create!(name: "sue", age: 15)
      @passenger_2 = Passenger.create!(name: "bob", age: 30)
      @southwest_1.passengers << @passenger_1
      @southwest_1.passengers << @passenger_2 
       
      expect(@southwest_1.number_adult).to eq(1)
       
    end
  end
end
