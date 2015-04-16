require 'csv'

class Car
  attr_reader :inventory_number, :make, :year, :model
  def initialize(attributes = {})
    @inventory_number = attributes[:inventory_number]
    @make =  attributes[:make]
    @model =  attributes[:model]
    @year =  attributes[:year]
  end

  def to_s
    string = ""
    string += "#{self.year}  #{self.make} #{self.model} ID: #{self.inventory_number}"
  end
end

class Dealership
  attr_reader :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars_by_make = []
    cars.each do |car|
      cars_by_make << car if car.make == make
    end
    cars_by_make
  end

  def pre(year)
    cars.select {|car| car.year < year}
  end

  def post(year)
     cars.select {|car| car.year > year}
  end

  def remove(id)
    cars.delete_if {|car| car.inventory_number == id}
  end

  def all
   cars
  end

  def newest_car
    cars.max_by {|car|  car.year}
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    CSV.read(filepath, :headers => true,:header_converters => :symbol).map { |row| Car.new(row) }
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
 dealership.find_make("Honda")



if ARGV[0] == "remove"
  puts dealership.remove(ARGV[1])
end
if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
   puts dealership.pre(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
    puts dealership.post(ARGV[2])
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  end
end
