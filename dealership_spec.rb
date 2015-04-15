require_relative('dealership')

describe Car do
end

describe CarLoader do
let(:cars) {CarLoader.get_cars_from_csv("inventory.csv")}

  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(Dealership.new(cars)).to be an_instance_of(Array)
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

    xit "returns an empty array when there are no cars of the given make" do
      # change 'xit' to 'it' and finish this test
    end
  end
end


