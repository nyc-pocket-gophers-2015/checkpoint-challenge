require 'csv'

class Car
  attr_reader :inventory_number, :make, :model, :year
  def initialize(array)
    @inventory_number = array[0]
    @make = array[1]
    @model= array[2]
    @year = array[3]
  end
  # I need to encapsulate these objects inside the dealership...
end

class Dealership
  attr_reader :cars, :inventory_number, :make, :model, :year, :sorted_cars
  def initialize(cars)
    @cars = cars
  end

  def find_make(make)
    cars_by_make = []
    @cars.each do |car|
      cars_by_make << car if car.make == make
    end
    cars_by_make
  end

  def newest_car
    # cars.each {|cars| if cars.year == "2002" puts cars end }
    # cars.group_by(&:year).each {|k,v| p k.to_i}
    # cars.each {|c_obj| c_obj.year.to_i}.max
    @sorted_cars = cars.sort_by {|car_obj| car_obj.year}
    sorted_cars[-2]
  end

  def display_made_after_yr(year)
     sorted_cars.each do |car_obj|
      if car_obj.year.to_i > year
        p car_obj
      end
    end
  end

  def display_made_before_yr(year) #delete first instance of headings and this works
     sorted_cars.each do |car_obj|
      if car_obj.year.to_i < year && car_obj.year != 'year'
        p car_obj
      end
    end
  end

  def display_car_make(make)
    sorted_cars.each do |car_obj|
      if car_obj.make == make
        p car_obj
      end
    end
  end


  def list_cars(filepath)

  end
end

module CarLoader

  def self.get_cars_from_csv(filepath)
    cars = []
    data = CSV.foreach(filepath){|row|
    cars << row}
    car_obj = cars.map! {|array| Car.new(array)}
    car_obj
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
dealership.find_make('Toyota')
dealership.newest_car
# dealership.made_after_yr(2004)
# dealership.display_made_before_yr(2001)
dealership.display_car_make('Honda')

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
  end
end
