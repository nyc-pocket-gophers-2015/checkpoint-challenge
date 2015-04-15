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
    cars_by_make
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
        return car
      end
    end
  end

  def pre(year)
    pre_array = []
    @cars.each do |car|
      if car.year < year.to_i
         pre_array << car
      end
    end
      pre_array
  end

  def post(year)
    post_array = []
    @cars.each do |car|
      if car.year > year.to_i
         post_array << car
      end
    end
      post_array
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

def nice_print(car)
  puts "#{car.year}, #{car.make} #{car.model}, ID : #{car.inventory_number}"
end

 cars = CarLoader.get_cars_from_csv("inventory.csv")
 cars.map! do |hash|
   Car.new(hash)
end

dealership = Dealership.new(cars)





if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
      dealership.cars.each do |car|
      nice_print(car)
    end
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
      dealership.find_make(ARGV[2]).each do |car|
      nice_print(car)
    end
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
      dealership.pre(ARGV[2]).each do |car|
      nice_print(car)
    end
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
     dealership.post(ARGV[2]).each do |car|
      nice_print(car)
    end
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
     nice_print(dealership.newest_car)
  end
end




# puts dealership.cars
