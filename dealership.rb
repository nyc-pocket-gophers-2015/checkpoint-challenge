require 'csv'

class Car
  attr_reader :make, :model, :inventory_number, :year
  def initialize(args)
    @make = args[:make]
    @model = args[:model]
    @inventory_number = args[:inventory_number]
    @year = args[:year]
  end

  def to_s
    "#{year} #{make} #{model} ID: #{inventory_number}"
  end
end

class Dealership
  def initialize(cars)
    @cars = cars
  end


  def cars
    @cars.each {|car| car}
  end

  def remove(id)
    @cars.delete_if{|car| car.inventory_number == id}
    CarLoader.write_to_csv("output.csv", @cars)
  end

  def add(hash)
    @cars << Car.new(hash)
    CarLoader.write_to_csv("output.csv", @cars)
  end

  def find_make(make)
    @cars.select{ |car| car.make == make }
  end

  def older_than(year)
    @cars.select { |car| car.year < year }
  end

  def newer_than(year)
    @cars.select { |car| car.year > year }
  end

  def newest_car
    @cars.sort_by{|car| car.year}.last
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    cars = []
    CSV.read(filepath, headers: true, header_converters: :symbol).each {|car| cars << car.to_hash}
    cars.map! {|element| Car.new(element)}
  end

  def self.write_to_csv(filepath, array)
    CSV.open(filepath, "w") do |file|
      file.puts ["inventory_number","make","model","year"]
      array.each do |car|
        file.puts ([car.inventory_number, car.make, car.model, car.year])
      end
    end
  end

end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    puts dealership.cars
  elsif ARGV[1] == "make"
    puts dealership.find_make(ARGV[2].capitalize)
  elsif ARGV[1] == "pre"
    puts dealership.older_than(ARGV[2])
  elsif ARGV[1] == "post"
    puts dealership.newer_than(ARGV[2])
  elsif ARGV[1] == "newest"
    puts dealership.newest_car
  end
elsif ARGV[0] == "remove"
  removal_id = ARGV[1]
  dealership.remove(removal_id)
elsif ARGV[0] == "add"
  car_hash = {
    inventory_number: ARGV[1],
    make: ARGV[2],
    model: ARGV[3],
    year: ARGV[4]
  }
  dealership.add(car_hash)
end



