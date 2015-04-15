require_relative('dealership')
require 'csv'
describe Car do
end

describe CarLoader do
  let(:car_object) CarLoader.get_cars_from_csv("inventory.csv")
  describe "#get_cars_from_csv" do
    xit "returns an array of Car objects" do
      expect(self.get_cars_from_csv).to eq ()
  end
end

describe Dealership do
  let(:cars) {[ Car.new(make: "Honda"),
                Car.new(make: "Toyota"),
                Car.new(make: "Honda")]}

  let(:dealership) { Dealership.new(cars)}

  describe "#find_make" do
    it "finds all cars of a given make" do
      expect(dealership.find_make("Honda").size).to eq(2)
    end

    it "returns an empty array when there are no cars of the given make" do
      expect(dealership.find_make("DBC").size).to eq(0)
    end
  end
end


