 require 'csv'
 require 'pry'
class Car
 attr_reader :inventory_number,:make,:model,:year
 def initialize(args={})
    @inventory = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year= args[:year]

end
end

class Dealership
    attr_reader :cars
  def initialize(cars=nil )
    @cars = cars || []
  end

  def find_make(make)
    cars_by_make = []
    @cars.each do |car|

      cars_by_make << car if car.make == make
    end

        cars_by_make.each{|car|
          puts "#{car.inventory_number} #{car.make}  #{car.model } #{car.year }"}
  end

  def find_year_pre(year)
    cars_by_year = []
    @cars.each do |car|
      cars_by_year << car if car.year < year.to_i
    end

       cars_by_year.each{|car|
          puts "#{car.inventory_number} #{car.make}  #{car.model } #{car.year } "}
  end
   def find_year_post(year)
    cars_by_year = []
    @cars.each do |car|
      cars_by_year << car if car.year > year.to_i
    end
       cars_by_year.each{|car|
          puts "#{car.inventory_number} #{car.make}  #{car.model } #{car.year } "}
  end


  def newest_car

    max = @cars[0]
    @cars.each do |car|
    max.replace(car) if car.year.to_i > max.year.to_i
    # I need to return the car on the lot that is the newest...
  end
  max
end

module CarLoader
  def self.get_cars_from_csv(filepath)
    file = File.read(filepath)
    cars = CSV.new(file, :headers => true, :header_converters => :symbol, :converters => [:all])
      cars.to_a.map { |row|  Car.new(row.to_hash)}

     # p cars.each{ |car| car_loot << Car.new(car)}

    end
end

 cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
   print dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
     dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
     dealership.find_year_pre(ARGV[2])
  elsif ARGV[1] == "post"
   # print cars made after the year supplied in ARGV[2]
     dealership.find_year_post(ARGV[2])
  elsif ARGV[1] == "newest"

    # print the newest car on the lot
        dealership.newest_car
    end
  end
end
