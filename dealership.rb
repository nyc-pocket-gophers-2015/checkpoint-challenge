require 'csv'

class Car
  # I need to encapsulate these objects inside the dealership...

  def intialize(attributes)
    @inventory_number = attributes[fetch(:inventory_number)]
    @make = attributes[fetch(:make)]
    @model = attributes[fetch(:model)]
    @year = attributes[fetch(:year)]
  end

end

class Dealership

  attr_accessor :cars

  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars_by_make = []
    @cars.each {|car| cars_by_make << car if car[:make] == make}
    cars_by_make
  end

  def pre(year)
    pre = []
    @cars.each{|car| pre << car if car[:year] < year}
    pre
  end

  def post(year)
    post = []
    @cars.each{|car| post << car if car[:year] > year}
    post
  end

  def newest_car
    newest = []
    newest = @cars.sort_by{|car| car[:year]}
    newest.pop
  end
end

def print_nice #if I have time
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    data_to_arr_of_hashes = []
    data = CSV.readlines(filepath)
    data.each_with_index{|row,idx|
      if idx > 0
        data_to_arr_of_hashes << {
          data[0][0].to_sym => row[0],
          data[0][1].to_sym => row[1],
          data[0][2].to_sym => row[2],
          data[0][3].to_sym => row[3]
        }
      end
    }
    data_to_arr_of_hashes
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
# dealership.find_make('Honda')
# cars = {[Car.new(make => "Honda")]}

# exit = false

# while (exit == false)

#   p "Please make a selection to search for cars on Deano's lot, or type 'exit' to end"
#   gets.chomp

# end



if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
    puts dealership.pre(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
    puts dealership.post(ARGV[2])
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  end
end
