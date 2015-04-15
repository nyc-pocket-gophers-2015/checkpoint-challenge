require_relative('dealership')

describe Car do
end

describe CarLoader do
  let(:cars) {CarLoader.get_cars_from_csv("inventory.csv")}
  describe "#get_cars_from_csv" do
   it "returns an array of Car objects" do
      expect(cars.find { |item| item[:inventory_number]}).to eq("55839")
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
  describe "#newest_car"
    it "finds the newest car" do
      expect(dealership.newest_car.id).to eq(78990)
    end
    # it "returns an empty array when there are no cars of the given make" do
    #   expect(dealership.find_make("Nissan").to eq("dl")
    # end
  end
end


