
class Car
  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  # I need to encapsulate these objects inside the dealership...
end

class Dealership
  def initialize(cars = nil)
    @cars = cars || []
    individual_car(@cars)
  end

  def find_make(make)
    # accepts a string as an arguement
    cars_by_make = []
    # creates an empty array
    # Looks at each car to determine if the make matches the make provided, if it does, shovel it into a new array and ultimately return that array
    @cars.each do |car|
      cars_by_make << car if (car[:make]).to_s == make
      end
      cars_by_make
  end

  def individual_car(list)
    list.each do |car|
      Car.new(car)
    end
  end
  def newest_car
    #sorts the array of hashes by the key given (year) and returns a sorted array of hashes.
    cars_by_year = @cars.sort_by {|car| car[:year]}
    return cars_by_year[-1]
    # returns the last car on the list, which is the newest car
    # I need to return the car on the lot that is the newest...
  end

  def list_cars
   sorted = @cars.sort_by {|car| car[:make]}
   sorted.each {|type| puts "#{type[:make]} #{type[:model]} #{type[:year]} #{type[:inventory_number]}"}
  end
end

module CarLoader
  require 'CSV'
  def self.get_cars_from_csv(filepath)
    CSV.read(filepath, :headers => true, :header_converters => :symbol).map {|row| row.to_hash}
    # returns all cars in an array of hashes with the headers inserted as keys
      # The result is being passed to the new dealership.
      # I need to return some useful data from this method...
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
 dealership = Dealership.new(cars)
 # p dealership.find_make("Honda")
 # p dealership.find_make('Honda')
# p dealership.newest_car
# p dealership.list_cars
# car = {:make => "Honda", :model => "Accord", :year => '2012', :inventory_number => "23657"}
# example = Car.new(car)
# p example

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.list_cars
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
