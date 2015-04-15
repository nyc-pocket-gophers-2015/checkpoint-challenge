require 'csv'
module CarLoader
  def self.get_cars_from_csv(filepath)
    CSV.read(filepath, { :headers => true, :header_converters => :symbol}).map { |row| Car.new(row.to_hash) }
  end

  def save_changes(filepath)
    CSV.open(filepath, "w") do |file|
      file << ["inventory_number", "make", "model", "year"]
      cars_to_csv_rows.each do |row|
        file << row
      end
    end
  end

  private

  def cars_to_csv_rows
    cars_rows = cars.map! do |car|
      [car.inventory_number,
      car.make,
      car.model,
      car.year]
    end
    return cars_rows
  end
end

class Car
  attr_reader :inventory_number, :make, :model, :year
  def initialize(hashdata)
    @inventory_number = hashdata[:inventory_number]
    @make = hashdata[:make]
    @model = hashdata[:model]
    @year = hashdata[:year]
  end
end

class Dealership
include CarLoader
  attr_accessor :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars_by_make = []
    cars.each do |car|
      cars_by_make << car if car.make == make
    end
    list_cars(cars_by_make)
  end

  def list_cars(cars = @cars)
    cars.each { |car| puts "#{car.year} #{car.make} #{car.model}, ID: #{car.inventory_number}" }
  end

  def newest_car
    sorted_by_year = cars.sort_by { |car| car.year.to_i }
    newest = sorted_by_year[-1]
    puts "Newest Car on the Lot: "
    puts "#{newest.year} #{newest.make} #{newest.model}, ID: #{newest.inventory_number}"
  end

  def newer_than(year)
    newer = cars.select { |car| car.year.to_i > year.to_i }
    puts "#{newer.length} results found: "
    list_cars(newer)
  end

  def older_than(year)
    older = cars.select { |car| car.year.to_i < year.to_i }
    puts "#{older.length} results found: "
    list_cars(older)
  end

  def sold_car(inventory_number)
    cars.delete_if { |car| car.inventory_number.to_i == inventory_number }
  end

  def add_car(car_object)
    cars << car_object
  end
end


huawei = Car.new(inventory_number: 32231, make: "Huawei", model: "Crappola", year: 1993)
cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
dealership.cars

dealership.sold_car(55839)
dealership.add_car(huawei)




#  dealership.find_make("Honda")
# # dealership.list_cars
# dealership.newer_than(1990)
# dealership.newest_car
# dealership.older_than(1990)
# dealership.save_changes("./inventory.csv")




if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
    puts dealership.older_than(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
    puts dealership.newer_than(ARGV[2])
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  end
end
