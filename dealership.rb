require 'csv'

class Car
 attr_accessor :inventory_number, :make, :model, :year
  # I need to encapsulate these objects inside the dealership...
   def initialize(attributes)
    @inventory_number = attributes[:inventory_number]
    @make = attributes[:make]
    @model = attributes[:model]
    @year = attributes[:year]

   end
end

class Dealership
  attr_accessor :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
     cars_by_make = []
     @cars.each do |car|
       if car.make == make
    cars_by_make << car
       end
   end
   p cars_by_make
  end

  def newest_car
    newest = 0
    @cars.each do |car|
      if car.year > newest
        newest = car.year
      end
    end
    @cars.each do |car|
      if car.year = newest
        return car.inspect
      end
    end

    # I need to return the car on the lot that is the newest...
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    data_hash = {}
    CSV.foreach(filepath, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data_hash[row.fields] = Hash[row.headers.zip(row.fields)]
    end
    array = [] #THIS RETURNS ALL CARS AS A HASH OF ARRAYS KEYED TO HASHES
    data_hash.map{|k,v| array << v}
    return array
    # The result is being passed to the new dealership.
    # I need to return some useful data from this method...
  end
end

 cars = CarLoader.get_cars_from_csv("inventory.csv")
 cars.map! do |hash|
   Car.new(hash)
end


dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
     puts dealership.cars.inspect
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  end
end

# puts dealership.cars
