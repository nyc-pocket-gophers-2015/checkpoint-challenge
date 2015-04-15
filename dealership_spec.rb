require_relative('dealership')

describe Car do
  let(:honda) { {make: "Honda", model: "Civic", year: 2000, id: 4} }
  describe "#initialize" do
    it 'can create instances of a Car object' do
      expect(Car.new(honda).class).to eq(Car)
    end
  end

  describe "#year" do
    it "should return the year of the car" do
      expect(Car.new(honda).year).to eq(2000)
    end
  end
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(CarLoader.get_cars_from_csv("inventory.csv").all? { |e| e.class == Car}).to eq(true)
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
      expect(dealership.find_make("Bentley").size).to eq(0)
    end
  end
end


