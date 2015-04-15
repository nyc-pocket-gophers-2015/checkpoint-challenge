require 'csv'

class Car
  attr_reader :make, :model, :inventory_number, :year
  def initialize(args)
    @make = args[:make]
    @model = args[:model]
    @inventory_number = args[:inventory_number]
    @year = args[:year]
  end
end

class Dealership

  def initialize(cars)
    @cars = cars
  end

  def cars
    @cars.each do |car|
      pretty_print_car(car)
    end
  end

  def pretty_print_car(car)
    puts "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}"
  end

  def print_group(array)
    array.each { |car| pretty_print_car(car) }
  end

  def cars
    print_group(@cars)
  end

  def find_make(make)
    print_group(@cars.select { |car| car.make == make })
  end

  def older_than(year)
    print_group(@cars.select { |car| car.year < year })
  end

  def newer_than(year)
    print_group(@cars.select { |car| car.year > year })
  end

  def newest_car
    pretty_print_car(@cars.sort_by{|car| car.year}.last)
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    cars = []
    CSV.read(filepath, headers: true, header_converters: :symbol).each {|car| cars << car.to_hash}
    cars.map! {|element| Car.new(element)}
  end

  def self.write_to_csv

  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
    dealership.older_than(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
    dealership.newer_than(ARGV[2])
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    dealership.newest_car
  end
elsif ARGV[0] == "remove"

end



