#Dealership System Use Cases:
  # Load cars from a file - done
  # List all cars on the lot
  # Display the newest car on the lot
  # Display all cars made after a given year
  # Display all cars made before a given year
  # Display all cars of a given make
require 'csv'

class Car
  # I need to encapsulate these objects inside the dealership...
  def initialize(args = {})
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  def to_s
    "#{@year} #{@make} #{@model}, ID: #{@inventory_number}"
  end
end

class Dealership

  attr_reader :cars

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
    CSV.read(filepath, :headers => true, :header_converters => :symbol).map do |car|
      Car.new(car.to_hash)
    end
  end
end

cars = CarLoader.get_cars_from_csv("./inventory.csv")
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
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



