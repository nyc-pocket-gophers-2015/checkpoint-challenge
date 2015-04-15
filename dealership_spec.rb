require_relative('dealership')

describe Car do
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    filepath = "./inventory.csv"

    it "returns an array" do
      expect(CarLoader.get_cars_from_csv(filepath)).to be_a(Array)
    end

    xit "returns an array of Car objects" do
      expect(CarLoader.get_cars_from_csv(filepath)).to be_a(Array.first)
      # expect(Array.first).to be_a(Car.new)
    end
  end
end

describe Dealership do
  let(:cars) {[ Car.new(make: "Honda", year: '2001', inventory_number: '55839'),
                Car.new(make: "Toyota", year: '2020', inventory_number: '558398'),
                Car.new(make: "Honda", year: '1999', inventory_number: '55837')]}

  let(:dealership) { Dealership.new(cars)}

  describe "#find_make" do
    it "finds all cars of a given make" do
      expect(dealership.find_make("Honda").size).to eq(2)
    end

    it "returns an empty array when there are no cars of the given make" do
      expect(dealership.find_make("Lexus").size).to eq(0)
    end

    it "should return the newest car on the lot" do
      expect(dealership.newest_car.inventory_number).to eq('558398')
    end
  end
end


