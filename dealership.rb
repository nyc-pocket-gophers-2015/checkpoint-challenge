# pseudocode 
# parser csv file with headers into an array of cars
# create car class with inventory_number, make, model and year attributes
# create a find_by method in class Dealership, that takes two arguments, find_by and value
require 'csv'

class Car
  
  attr_reader :inventory_number, :make, :model, :year

  def initialize(args)
    @to_hash = args
    @inventory_number = args.fetch(:inventory_number,0)
    @make = args.fetch(:make,"ND")
    @model = args.fetch(:model,"ND")
    @year = args.fetch(:year,0)
  end

  def to_s
    "#{inventory_number}\t\t#{make}\t\t#{model}\t\t#{year}"
  end

  def to_hash
    @to_hash
  end
end

class Dealership
  
  attr_reader :cars

  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_by(find_by, value, &block)
      @cars.select{|car| block.call(car, find_by, value)}
  end

  def find_make(make)
    # @cars.select{|car| car.make.downcase == make.downcase}
    find_by("make",make){ |car,find_by,value| car.instance_variable_get("@#{find_by}").downcase == value.downcase }
  end

  def newest_car
      @cars.max_by{|car| car.year.to_i }
  end

  def add_car(inventory_number,make,model,year)
    car = Car.new(inventory_number: inventory_number, make: make, model: model, year: year)
    @cars << car
  end

  def remove_car(inventory_number)
    @cars.delete_if{|car| car.inventory_number == inventory_number}
  end

  def save
    CarLoader.save("inventory.csv",@cars.map{|car| car.to_hash} )
  end
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    cars = []
    CSV.foreach(filepath,:headers => true, :header_converters => :symbol) do |row|
        cars << Car.new(row.to_hash)
    end
    cars
  end

  def self.save(file, data)
    CSV.open(file, "w") do |row|
      row << data[0].keys
      data.each {|entry| row << entry.values }
    end
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

# puts dealership.find_make("Honda")

def display_deano_console_top_message
  puts "*"*55
  puts "---------------Deano's Dealership lot---------------"

end

def display_deano_console_bottom_message
  puts "*"*55
  puts "---------------Phone 555.555.5555---------------"

end

def display_options(dealership)
  display_deano_console_top_message
  puts "--------------Menu Options-----------------"
  puts "1 - Find Car"
  puts "2 - Add Car"
  puts "3 - Remove Car "
  puts "4 - exit"
  display_deano_console_bottom_message
  option = $stdin.gets.chomp
  case option
  when "1" then display_find_cars(dealership)
  when "2" then display_add_car_options(dealership)
  when "3" then display_remove_car_options(dealership)
  when "4" then return
  else puts "Please indicate an option from 1 to 3"
  end
end

def display_add_car_options(dealership)
    puts "Please indicate car inventory number :"
    inventory_number = $stdin.gets.chomp
    puts "Please indicate car make"
    make = $stdin.gets.chomp
    puts "Please indicate car model"
    model = $stdin.gets.chomp
    puts "Please indicae car year"
    year = $stdin.gets.chomp
    dealership.add_car(inventory_number,make,model,year)
    dealership.save
    puts "Car added successfully"
end

def display_remove_car_options(dealership)
    puts "Please indicate car inventory number :"
    inventory_number = $stdin.gets.chomp
    puts "Are you sure you want to remove car #{inventory_number} from inventory"
    puts "1 - yes "
    puts "2 - no"
    confirm = $stdin.gets.chomp
    if confirm == "1"
      dealership.remove_car(inventory_number)
      dealership.save
      puts "Car #{inventory_number} removed."
    end
end

def display_find_cars(dealership)
  display_deano_console_top_message
  puts "--------------Menu Options-----------------"
  puts "make [make] - Find Car make by"
  puts "pre  [year] - Find Car pre year"
  puts "post [year] - Find Car post year"
  puts "newest      - Find newest Car "
  puts "all         - Find all Cars"
  display_deano_console_bottom_message
  option = $stdin.gets.chomp
  options = option.split(" ")
  find_by(options[0],options[1],dealership)
end

def find_by(option, value,dealership)
  if option == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif option == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(value)
  elsif option == "pre"
    # print cars made before the year supplied in value
    puts dealership.find_by('year',value.to_i){|car,find_by,value| car.instance_variable_get("@#{find_by}").to_i <= value}
  elsif option == "post"
    # print cars made after the year supplied in value
    puts dealership.find_by('year',value.to_i){|car,find_by,value| car.instance_variable_get("@#{find_by}").to_i >= value}
  elsif option == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  else
    puts ""
    puts "No car found for your search."
    puts ""
  end

end

if ARGV[0] == "find"
     display_deano_console_top_message
     if ARGV[1] == "all"
       # print all of the cars on Deano's lot
       puts dealership.cars
     elsif ARGV[1] == "make"
       # print cars of the make supplied in ARGV[2]
       puts dealership.find_make(ARGV[2])
     elsif ARGV[1] == "pre"
       # print cars made before the year supplied in ARGV[2]
       puts dealership.find_by('year',ARGV[2].to_i){|car,find_by,value| car.instance_variable_get("@#{find_by}").to_i <= value}
     elsif ARGV[1] == "post"
       # print cars made after the year supplied in ARGV[2]
       puts dealership.find_by('year',ARGV[2].to_i){|car,find_by,value| car.instance_variable_get("@#{find_by}").to_i >= value}
     elsif ARGV[1] == "newest"
       # print the newest car on the lot
       puts dealership.newest_car
     else
       puts ""
       puts "No car found for your search."
       puts ""
     end
     display_deano_console_bottom_message
   else
     puts "#{ARGV[0]} is not a valid command try find instead" 
     puts "Consider using the menu options"
     display_options(dealership)
   end
