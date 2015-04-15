require_relative('dealership')

describe Car do
  let(:huawei) {Car.new(inventory_number: 32231,
                        make: "Huawei",
                        model: "Crappola",
                        year: 1993)}
  describe "#initialize" do
    it "creates a car object with an inventory_number, make, model, and year" do
      expect(huawei).to be_a(Car)
      expect(huawei.model).to eq("Crappola")
      expect(huawei.make).to eq("Huawei")
      expect(huawei.year).to eq(1993)
      expect(huawei.inventory_number).to eq(32231)
  end
  end
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(csvarray = CarLoader.get_cars_from_csv('./inventory.csv')).to be_a(Array)
      expect(csvarray.all? { |element| element.class == Car }).to be(true)
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
      expect(dealership.find_make("Huawei").size).to eq(0)
    end
  end
end


