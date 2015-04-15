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

  def add_car_to_lot
    ARGV.clear
    puts "Please tell us the year of the car"
    year = gets.chomp
    puts "Please tell us the make of the car"
    make = gets.chomp
    puts "Please tell us the model of the #{make}"
    model = gets.chomp
    puts "Please tell us the dealerships inventory_number (6 digits)"
    inventory_number = gets.chomp
    cars << Car.new(make: make, model: model, year: year, inventory_number: inventory_number)
    puts "You just added a #{year} #{make} #{model} to the lot!"
    puts "Would you like to see all the cars in the lot? (yes or no)"
    answer = gets.chomp
    puts all_cars if answer.downcase == "yes"
  end

  def remove_car_from_lot
    ARGV.clear
    puts "Please tell us the Id of the car you'd like to print. Would you like to see a list of cars?('yes' or 'no')"
    answer = gets.chomp
    puts all_cars if answer == 'yes'
    puts "Please enter the ID of the car you'd like to remove from the lot:"
    id = gets.chomp
    car_deleted = cars.find {|car| car.inventory_number == id.to_s}
    car_deleted = "#{car_deleted.year} #{car_deleted.make} #{car_deleted.model}"
    cars.delete_if {|car| car.inventory_number == id.to_s }
    puts "You just deleted the #{car_deleted}"; sleep(0.5)
    puts "Would you like to see all the cars in the lot? (yes or no)"
    answer = gets.chomp
    puts all_cars if answer.downcase == "yes"
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

  def self.save_cars_to_csv(filepath, data)
    CSV.open(filepath, "w") do |row|
      row << data[0].instance_variables.map {|var| var.to_s.delete("@")}
      data.each do |car|
        row << [car.inventory_number, car.make, car.model, car.year]
      end
    end
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

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
elsif ARGV[0] == "remove"
  dealership.remove_car_from_lot
  CarLoader.save_cars_to_csv('inventory.csv', dealership.cars)
elsif ARGV[0] == "add"
  dealership.add_car_to_lot
  CarLoader.save_cars_to_csv('inventory.csv', dealership.cars)
end