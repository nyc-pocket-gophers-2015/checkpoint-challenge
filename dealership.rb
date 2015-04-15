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
    array << self.inventory_number
    array << self.make
    array << self.model
    array << self.year
    array.join(',')
  end

end

class Dealership
  attr_accessor :cars
  def initialize(cars = [])
    @cars = cars

  end

  def list
    puts @cars
  end

  def pre
    year = []
    self.cars.each do |car|
      car.year < ARGV[2] ?  year << car : car
    end
  puts  year
  end

  def post
    year = []
    self.cars.each do |car|
      car.year > ARGV[2] ?  year << car : car
    end
  puts  year
  end

  def find_make
    make = []
    @cars.each do |car|
      make << car if car.make == (ARGV[2])
    end
   puts make
  end

  def newest_car
    puts @cars.sort {|a,b| a.year <=> b.year}.last
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
  CSV.read(filepath, :headers => true,:header_converters => :symbol).map { |row| Car.new(row.to_hash)}
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
# dealership.list
# dealership.newest_car



if ARGV[0] == "find"
  if ARGV[1] == "all"
    dealership.list
  elsif ARGV[1] == "make"
    dealership.find_make
  elsif ARGV[1] == "pre"
    dealership.pre
  elsif ARGV[1] == "post"
    dealership.post
  elsif ARGV[1] == "newest"
    dealership.newest_car
  end
end
