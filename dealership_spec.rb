require_relative('dealership')
require_relative ('cars')
require_relative ('carloader')
require_relative ('view')

# describe Car do
# end

# describe CarLoader do
#   describe "#get_cars_from_csv" do
#     xit "returns an array of Car objects" do
#       # change 'xit' to 'it' and finish this test
#     end
#   end
# end

describe Dealership do
  let(:cars) {[ Cars.new(make: "Honda"),
                Cars.new(make: "Toyota"),
                Cars.new(make: "Honda")]}

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