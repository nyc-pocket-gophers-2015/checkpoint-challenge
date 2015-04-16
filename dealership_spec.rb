require_relative('dealership')

describe Car do
end

describe CarLoader do
  describe "#get_cars_from_csv" do
    it "returns an array of Car objects" do
      expect(CarLoader.get_cars_from_csv("inventory.csv")).to be_a(Array)
    end
  end
end

describe Dealership do
  let(:cars) {[ Car.new(make: "Honda" ,year: 2014),
                Car.new(make: "Toyota", year: 2002),
                Car.new(make: "Honda", year: 1999)]}

  let(:dealership) { Dealership.new(cars)}

  describe "#find_make" do
    it "finds all cars of a given make" do
      expect(dealership.find_make("Honda").size).to eq(2)
    end

    it "finds all cars of a given make" do
      expect(dealership.find_make("Toyota").size).to eq(1)
    end

      it "returns an empty array when there are no cars of the given make" do
       expect(dealership.find_make("DBC").size).to eq(0)
     end

     describe "#all" do
        it "should return all cars to user" do
          expect(dealership.all.size).to eq(3)
       end

       describe "#newest" do
          it "should return newest car to user" do
            expect(dealership.newest_car.year).to eq(2014)
          end
       end


       describe "pre" do
          it "should return all car objects before a certain year " do
            expect(dealership.pre(2014).size).to eq(2)
          end
       end

       describe "post" do
          it "should return all car objects after a certain year " do
            expect(dealership.post(1999).size).to eq(2)
          end
       end
     end
  end
end


