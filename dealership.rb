require 'csv'

class Car
  attr_accessor :inventory_number, :make, :model, :year
  def initialize(args = {})
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  def to_s
    array = []
    array << self.year
    array << self.make
    array << self.model
    array << "ID: " + self.inventory_number
    array.join(' ')
  end
end

class Dealership
  attr_accessor :cars
  def initialize(cars = [])
    @cars = cars
  end

  def list
    @cars
  end

  def pre(input)
    self.cars.select do |car|
      car.year < input
    end

  end

  def post(input)
    self.cars.select do |car|
      car.year > input
    end
  end

  def find_make(make)
    @cars.select do |car|
      car.make == make
    end
  end

  def newest_car
    @cars.sort {|a,b| a.year <=> b.year}.last
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
  CSV.read(filepath, :headers => true,:header_converters => :symbol).map { |row| Car.new(row.to_hash)}
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)


if ARGV[0] == "find"
  if ARGV[1] == "all"
  puts  dealership.list
  elsif ARGV[1] == "make"
  puts  dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
  puts  dealership.pre(ARGV[2])
  elsif ARGV[1] == "post"
  puts  dealership.post(ARGV[2])
  elsif ARGV[1] == "newest"
  puts  dealership.newest_car
  end
end
