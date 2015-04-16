require 'csv'
require_relative 'module'

class Car
  attr_reader :inventory_number, :make, :model, :year
  def initialize(args={})
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end
end

class Dealership
  attr_reader :cars

  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars.select do |car|
      car.make.upcase == make.upcase
    end
  end

  def find_pre(year)
    cars.select do |car|
      car.year.to_i < year.to_i
    end
  end

  def find_post(year)
    cars.select do |car|
      car.year.to_i > year.to_i
    end
  end

  def newest_car
    cars.sort_by do |car|
      car.year
    end.last
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    Parser.import(filepath).map {|car_data| Car.new car_data }
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)


if ARGV[0] == "find"

  if ARGV[1] == "all"
    find_all_cars_results = dealership.cars
    count = 1
    puts "Displaying All Cars:"
    puts "-------------------------------------"
    find_all_cars_results.each do |car|
      puts "#{count}: #{car.inventory_number} #{car.make} #{car.model} #{car.year}"
      count +=1
      puts "-------------------------------------"
    end
    puts "    #{count-1} Total Cars"

  elsif ARGV[1] == "make"
    puts "make"
    make_results = dealership.find_make(ARGV[2].to_s)
    count = 1
    puts "Displaying All Cars of Make #{ARGV[2]}:"
    puts "-------------------------------------"
    make_results.each do |car|
      puts "#{count}: #{car.inventory_number} #{car.make} #{car.model} #{car.year}"
      count +=1
    puts "-------------------------------------"
    end
    puts "    #{count-1} Total Cars"
  elsif ARGV[1] == "pre"
    cars_results = dealership.find_pre(ARGV[2].to_i)
    count = 1
    puts "Displaying Cars Before: #{ARGV[2]}"
    puts "-------------------------------------"
    cars_results.each do |car|
      puts "#{count}: #{car.inventory_number} #{car.make} #{car.model} #{car.year}"
      count +=1
      puts "-------------------------------------"
    end
    puts "    #{count-1} Total Cars"
  elsif ARGV[1] == "post"
    cars_results = dealership.find_post(ARGV[2].to_i)
    count = 1
    puts "Displaying Cars After: #{ARGV[2]}"
    puts "-------------------------------------"
    cars_results.each do |car|
      puts "#{count}: #{car.inventory_number} #{car.make} #{car.model} #{car.year}"
      count +=1
      puts "-------------------------------------"
    end
    puts "    #{count-1} Total Cars"
  elsif ARGV[1] == "newest"
    newest_car = dealership.newest_car
    count = 1
    puts "Displaying Newest Car:"
    puts "-------------------------------------"
      puts "#{count}: #{newest_car.inventory_number} #{newest_car.make} #{newest_car.model} #{newest_car.year}"
      puts "-------------------------------------"
    puts "    #{count} Total Cars"
  end
end
