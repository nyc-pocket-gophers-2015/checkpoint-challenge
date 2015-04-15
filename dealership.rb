
class Car #defines a car
  attr_reader :make, :model, :inventory_number, :year
  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  # I need to encapsulate these objects inside the dealership...
end

class Dealership
  attr_accessor :cars
  def initialize(cars = nil)
    @cars = cars || []
    list_cars(@cars)
  end

  def find_make(make, cars_by_make = [])
    # accepts a string as an arguement
    # Looks at each car to determine if the make matches the make provided, if it does, shovel it into a new array and ultimately return that array
    cars.each do |car|
      cars_by_make << car if (car.make).to_s == make
      end
      cars_by_make
  end

  def parsed_car_list(list) # creates a new car instance for each car the dealership has
    parsed_cars = []
    list.each do |car|
     parsed_cars << car
    end
    p parsed_cars
  end

  def newest_car
    #sorts the array of hashes by the key given (year) and returns a sorted array of hashes.
    cars_by_year = cars.sort_by {|car| car.year}
    return cars_by_year[-1]
  end

  def post_cars(post_year) #returns all the cars that are post the given year
    total_cars = @cars.select {|car| (car.year).to_i > (post_year).to_i}
    # p total_cars
    total_cars.each {|car| Car.new(car)}
  end

  def pre_cars(pre_year) #returns an array of hashs of cars that are pre the given year
    @cars.select {|car| (car.year).to_i < (pre_year).to_i}
  end

  def list_cars
   sorted = @cars.sort_by {|car| car.make}
   sorted.each {|type| puts "#{type.make} #{type.model} #{type.year} #{type.inventory_number}"}
  end
end

module CarLoader
  require 'CSV'
  def self.get_cars_from_csv(filepath)
    CSV.read(filepath, :headers => true, :header_converters => :symbol).map {|row| Car.new(row)}
    # returns an array of car objects

  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
p cars
dealership = Dealership.new(cars)



if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.list_cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    # I know this should give me the car objects, and not the car information from the hash.
    p dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    puts dealership.pre_cars(ARGV[2])
    # print cars made before the year supplied in ARGV[2]
  elsif ARGV[1] == "post"
    puts dealership.post_cars(ARGV[2])
    # print cars made after the year supplied in ARGV[2]
  elsif ARGV[1] == "newest"
    puts dealership.newest_car
    # print the newest car on the lot
  end
end
