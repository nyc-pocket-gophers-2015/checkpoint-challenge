require 'csv'

class Car
  attr_reader :inventory_number, :make, :model, :year
  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end
end

class Dealership
  def initialize(cars = nil)
    @cars = cars || []
    load_cars_into_dealership(cars)
  end

  def load_cars_into_dealership(cars, pending_cars = [])
    cars.each do |car|
      pending_cars << car
    end
    @cars = pending_cars
  end

  def find_make(make, cars_by_make = [])
    @cars.each do |car|
      cars_by_make << car if car.make.upcase == make.upcase
    end
    cars_by_make
  end

  def find_pre(year, results = [])
    @cars.each do |car|
      results << car if car.year.to_i < year.to_i
    end
    return results
  end

  def find_post(year, results = [])
    @cars.each do |car|
      results << car if car.year.to_i > year.to_i
    end
    return results
  end

  def newest_car(newest_car = nil)
    @cars.each do |car|
      if newest_car == nil || car.year > newest_car.year
        newest_car = car
      end
    end
    return newest_car
  end

  def find_all_cars(all_cars = [])
    @cars.each_with_index do |car, index|
      all_cars << car
    end
    all_cars
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath, data= [], results = [])
    options = {encoding: "UTF-8", headers: true, header_converters: :symbol}
    CSV.foreach(filepath, options) {|row| data << row.to_hash}
    data.each do |car|
      inventory_number = car[:inventory_number]
      make = car[:make]
      model = car[:model]
      year = car[:year]
      results << Car.new(inventory_number: inventory_number, make: make, model: model, year: year)
    end
    return results
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)


if ARGV[0] == "find"

  if ARGV[1] == "all"
    find_all_cars_results = dealership.find_all_cars
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