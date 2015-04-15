require_relative('dealership')

describe Car do
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      # change 'xit' to 'it' and finish this test
    end
  end
end

describe Dealership do
  let(:cars) {[ Car.new(id: "55555", make: "Honda", year: "2012"),
                Car.new(id: "44444", make: "Toyota", year: "2010"),
                Car.new(id: "33333", make: "Honda", year: "2000")]}

  let(:dealership) { Dealership.new(cars)}

  describe "#find_make" do
    it "finds all cars of a given make" do
      expect(dealership.find_make("Honda").length).to eq(2)
    end

    it "returns an empty array when there are no cars of the given make" do
      # change 'xit' to 'it' and finish this test
      expect(dealership.find_make("Mitsubishi")).to eq(0)
    end
  end

  describe "#newest_car" do
    it "finds the newest car" do
      expect(dealership.newest_car.id).to eq("55555")
    end
  end
end


