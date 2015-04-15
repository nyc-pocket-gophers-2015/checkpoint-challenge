require 'csv'

class Car

  attr_reader :make, :model, :year, :inventory_number

  def initialize(args)
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
    @inventory_number = args[:inventory_number]
  end

end

class Dealership

  attr_reader :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def all_cars
    to_s(cars)
  end

  def find_make(make)
    cars_by_make = []
    cars.each do |car|
      cars_by_make << car if car.make.upcase == make.upcase
    end
    to_s(cars_by_make)
  end

  def newest_car
    newest_cars = []
    newest_year = "0"
    cars.each do |car|
      newest_year = car.year if car.year > newest_year
    end
    cars.each do |car|
      newest_cars << car if car.year == newest_year
    end
    to_s(newest_cars)
  end

  def pre year
    queried = []
    cars.each do |car|
      queried << car if car.year.to_i < year.to_i
    end
    to_s(queried)
  end

  def post year
    queried = []
    cars.each do |car|
      queried << car if car.year.to_i > year.to_i
    end
    to_s(queried)
  end

  def to_s(cars_to_print = car_objects)
    car_display = []
    cars_to_print.each do |car|
      car_display << "#{car.year} #{car.make} #{car.model}, ID: #{car.inventory_number}"
    end
    car_display
  end

  private
  def create_car_objects
    the_cars = []
    cars.each do |car_hash|
      the_cars << Car.new(car_hash)
    end
    the_cars
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    cars = []
    CSV.read(filepath, headers: true, header_converters: :symbol).each do |row|
      cars << Car.new(row.to_hash)
    end
    cars
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
dealership.find_make("Honda")


###
# a = Car.new(make: "Honda")
# b = Car.new(make: "Honda")
# c = Car.new(make: "Toyota")
# dealership = Dealership.new([a,b,c])
# p dealership.find_make("honda")

if ARGV[0] == "find"
  if ARGV[1] == "all"
    puts dealership.all_cars
  elsif ARGV[1] == "make"
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    raise "Year must be 4 digits" unless ARGV[2].length == 4
    puts dealership.pre(ARGV[2])
  elsif ARGV[1] == "post"
    raise "Year must be 4 digits" unless ARGV[2].length == 4
    puts dealership.post(ARGV[2])
  elsif ARGV[1] == "newest"
    puts dealership.newest_car
  end
end

