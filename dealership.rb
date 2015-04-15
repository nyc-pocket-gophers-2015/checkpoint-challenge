# Dealership System Use Cases:
  # Load cars from a file - done
  # List all cars on the lot - done
  # Display the newest car on the lot - done
  # Display all cars made after a given year - done
  # Display all cars made before a given year - done
  # Display all cars of a given make - done
  # Ability to remove a car from the master file, by entering the car's ID.
  # Ability to add a car (and all of its details) to the master file.


require 'csv'

class Car
  # I need to encapsulate these objects inside the dealership...
  attr_reader :make, :year, :inventory_number

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
    if make == 'bmw'
      make = 'BMW'
    else
      make = make.capitalize
    end
    cars_by_make = []
    @cars.each { |car| cars_by_make << car if car.make == make }
    cars_by_make
  end

  def find_pre(year)
    cars_pre_year = []
    @cars.each { |car| cars_pre_year << car if car.year < year}
    cars_pre_year
  end

  def find_post(year)
    cars_post_year = []
    @cars.each { |car| cars_post_year << car if car.year > year}
    cars_post_year
  end

  def newest_car
    @cars.max_by { |car| car.year }
  end

  def remove_car(inventory_number)
    #find in cars array
    #remove it from the array
    #rewrite the file
    @cars.delete_if {|car| car.inventory_number == inventory_number}
    save
    return "deleted car id:#{inventory_number}"
  end

  def add_car(details)

  end

  def save(filepath = "./inventory.csv")
    # car_rows = @cars.map! do |car|
    #   ['inventory_number','make','model','year']
    # end
    CSV.open(filepath,'w') do |file|
      file << ['inventory_number','make','model','year']
      @cars.each do |entry|
        file << entry
      end
    end
  end

end

module CarLoader
  def self.get_cars_from_csv(filepath)
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
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    puts dealership.find_pre(ARGV[2])
  elsif ARGV[1] == "post"
    puts dealership.find_post(ARGV[2])
  elsif ARGV[1] == "newest"
    puts dealership.newest_car
  elsif ARGV[1] == "remove"
    puts dealership.remove_car(ARGV[2])
  elsif ARGV[1] == "add"
    puts dealership.add_car(ARGV[2])
  end
end