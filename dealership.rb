class Car
  # I need to encapsulate these objects inside the dealership...
end

class Dealership
  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars_by_make = []
    @cars.each do |car|
      cars_by_make << car if car.make == make
    end
    cars_by_make
  end

  def newest_car
    # I need to return the car on the lot that is the newest...
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    # The result is being passed to the new dealership.
    # I need to return some useful data from this method...
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
  end
end
