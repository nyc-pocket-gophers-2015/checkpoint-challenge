require_relative('dealership')

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(CarLoader.get_cars_from_csv("inventory.csv")).to be_a(Array)
    end
  end
end

describe Car do
  let(:car) {Car.new(make: "Honda", inventory_number: 123123, model: "Civic", year: 1978)}

   describe "Car" do
    it "it should have a make value" do
      expect(car.make).to eq("Honda")
    end

    it "it should have a Model" do
      expect(car.model).to eq("Civic")
    end

    it "it should have a year" do
      expect(car.year).to eq(1978)
    end

    it "it should have an inventory_id" do
      expect(car.inventory_number).to eq(123123)
    end
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
     expect(dealership.find_make("Tesla").size).to eq(0)
    end
  end
end


