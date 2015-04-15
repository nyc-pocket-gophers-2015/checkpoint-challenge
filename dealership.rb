require 'csv'


class Car
  attr_accessor :inventory_number, :make, :model, :year
  def initialize(args = {})
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end
end

class Dealership
  attr_accessor :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def list(filepath)
    @cars = CarLoader.get_cars_from_csv(filepath).map { |row| Car.new(row.to_hash)}
    @cars.map! do |car|
      car.instance_variables.map! {|info|  car.instance_variable_get(info)}
    end
     @cars.each {|car| p car.join(',')}

  end

  def find_make(make)
    cars_by_make = []
    @cars.each do |car|
      cars_by_make << car if car.make == make
    end
    cars_by_make
  end

  def newest_car
    @cars.last
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
  CSV.read(filepath, :headers => true,:header_converters => :symbol).map {|row| row.to_hash}
  end
end

#cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new
p dealership.list("inventory.csv")
p dealership.newest_car.join(',')



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
