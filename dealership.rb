require 'csv'

module Parser
  require 'csv'
  
  def self.import filepath
    config = {headers: true, header_converters: :symbol}
    CSV.read(filepath, config).map {|row| row.to_hash}
  end

  def self.save filepath, data  
    CSV.open(filepath, "wb") do |file|
      file << data.first.keys
      data.each { |row| file << row.values }
    end
  end
end

class Car
  # I need to encapsulate these objects inside the dealership...
  attr_reader :inventory_number, :make, :year, :model
  def initialize(attributes = {})
    @inventory_number = attributes[:inventory_number]
    @make = attributes[:make]
    @model = attributes[:model]
    @year = attributes[:year]
  end

  def to_hash
    result = {}
    clean_variables = instance_variables.map {|iv| iv[1..-1].to_sym }
    clean_variables.each do |instance_variable|
      result[instance_variable] = instance_variable_get("@#{instance_variable}")
    end
    result
  end

end

class Dealership

  attr_accessor :cars

  def initialize(cars = nil)
    @cars = cars || []
  end

  def formatted_cars #attempted ot reformat data to make rspec work
    cars.map {|car| car.to_hash}
  end

  def find_make(make)
    @cars.select {|car| car.make == make}
  end

  def pre(year)
    @cars.select {|car| car.year < year}
  end

  def post(year)
    @cars.select{|car| car.year > year}
  end

  def newest_car
    sorted_cars = @cars.sort_by do|car| 
      car.year
    end
    sorted_cars.last
  end

  def save
    Parser.save("inventory.csv", formatted_cars)
  end
end

def print_nice(output) #if I have time
  # output.each{|car|
  #   p car
  #   # p car[:make]
  #   # p car[:model]
  #   # p "ID:"
  #   # p car[:inventory_number]
  # }
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    Parser.import(filepath)
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv").map {|attrs| Car.new attrs}
dealership = Dealership.new(cars)
# p cars
# dealership.find_make('Honda')
# cars = {[Car.new(make => "Honda")]}

# exit = false

# while (exit == false)

#   p "Please make a selection to search for cars on Deano's lot, or type 'exit' to end"
#   gets.chomp

# end



# p cars = [ Car.new(make: "Honda"), Car.new(make: "Honda"),
#                 Car.new(make: "Toyota"),
#                 Car.new(make: "Honda")]

# dealership = Dealership.new(cars)

# p cars

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
