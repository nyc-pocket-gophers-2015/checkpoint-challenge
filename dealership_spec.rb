require_relative('dealership')

describe Car do
  describe "#"
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    let(:cars) {CarLoader.get_cars_from_csv('inventory.csv')}
    it "returns an array of Car objects" do
      expect(cars[0]).to be_kind_of(Car)
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
      expect(dealership.find_make("Maserati")).to eq([])
    end
  end
end


