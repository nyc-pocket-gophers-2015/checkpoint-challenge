require_relative('dealership')

require 'pry'

describe Car do
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(CarLoader.get_cars_from_csv("inventory.csv")).to be_a Array
    end
  end
end

describe Dealership do
  let(:cars) {[ Car.new(make: "Peugot", year: 1980),
                Car.new(make: "Honda", year: 1999),
                Car.new(make: "Toyota", year: 2000),
                Car.new(make: "Honda", year: 2010)]}

  let(:dealership) { Dealership.new(cars)}

  describe "#find_make" do
    it "finds all cars of a given make" do
      expect(dealership.find_make("Honda").size).to eq(2)
    end

    it "returns an empty array when there are no cars of the given make" do
      expect(dealership.find_make("Tesla")).to eq([])
    end
  end

  describe "#newest" do
    it "returns the object that is the newest car" do
       # binding.pry
      expect(dealership.newest_car.year).to eq(2010)
    end
  end

  describe "#pre" do
    it "returns only cars that are made before a specific year" do
      expect(dealership.pre(2000).length).to eq(2)
    end
  end

  describe "#post" do
    it "returns only the cars that are made after a specific year" do
      expect(dealership.post(2000).length).to eq(1)
    end
  end
end


