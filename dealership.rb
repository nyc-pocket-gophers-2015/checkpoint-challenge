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

  def initialize(cars = nil)
    @cars = cars || []
    @car_obj = create_car_objects
  end

  def cars # Decided on this because if I printed the cars method (by attr_reader) it would
    to_s(@cars) #   print a hash and if I printed the dealership it would print the
  end           #   object ID of dealership

  def find_make(make)
    cars_by_make = []
    @cars.each do |car|
      cars_by_make << car if car[:make].upcase == make
    end
    to_s(cars_by_make)
  end

  def newest_car
    newest_cars = []
    newest_year = "0"
    @cars.each do |car|
      if car[:year] > newest_year
        newest_year = car[:year]
      end
    end
    @cars.each do |car|
      newest_cars << car if car[:year] == newest_year
    end
    to_s(newest_cars)
  end

  def pre year
    queried = []
    @cars.each do |car|
      queried << car if car[:year].to_i < year.to_i
    end
    to_s(queried)
  end

  def post year
    queried = []
    @cars.each do |car|
      queried << car if car[:year].to_i > year.to_i
    end
    to_s(queried)
  end

  def to_s(cars_to_print = @cars)
    car_display = []
    cars_to_print.each do |car|
      car_display << "#{car[:year]} #{car[:make]} #{car[:model]}, ID: #{car[:inventory_number]}"
    end
    car_display
  end

  private
  def create_car_objects
    car_objects = []
    @cars.each do |car_hash|
      car_objects << Car.new(car_hash)
    end
    p car_objects
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    cars = []
    CSV.read(filepath, headers: true, header_converters: :symbol).each do |row|
      cars << row.to_hash
    end
    cars
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
dealership.find_make("Honda")

if ARGV[0] == "find"
  if ARGV[1] == "all"
    puts dealership.cars
  elsif ARGV[1] == "make"
    puts dealership.find_make(ARGV[2].upcase)
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


a = Car.new(make: "Honda")
b = Car.new(make: "Honda")
c = Car.new(make: "Toyota")

dealership2 = Dealership.new([a,b,c])
# p dealership2.find_make("honda")