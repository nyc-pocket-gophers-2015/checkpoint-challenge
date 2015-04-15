require 'csv'

class Car
 attr_reader :inventory_number, :make, :model, :year
 def initialize(car = {})
   @inventory_number = car[:inventory_number]
   @make = car[:make]
   @model = car[:model]
   @year = car [:year]
 end
end

class Dealership
  def initialize(cars = nil)
    @cars = cars || []
  end

  # def car_objects(file)
  #   @car = CarLoader.get_cars_from_csv(file).map{|row| Car.new(row) }
  # end

  def find_make(make)
    cars_by_make = []
    hacky_i_know = []
    @cars.each do |car|
      cars_by_make << car if car.make == make
    end
    cars_by_make.each do |car|
     hacky_i_know << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}"
    end
    hacky_i_know
  end


  # almost finished with this
  # def pre(year)
  #   result = []
  #   final = []
  #   result << @cars.reject { |car| car.year.to_i > year }
  #   result.flatten.each do |car|
  #     final << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}"
  #   end
  #    final
  # end

  # def post
  # end


  def all
    new = []
    @cars.each do |car|
        new.push( "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}")
    end
     new
  end

  def newest
    new = []
    @cars.each do |car|
      new << car
      new.sort! { |a, b|  a.year <=> b.year }
    end
     "Make:#{new[-1].make}    Model:#{new[-1].model}     Year:#{new[-1].year}"
  end

end

module CarLoader
  def self.get_cars_from_csv(filepath)
    CSV.read(filepath, :headers => true,:header_converters => :symbol).map { |row| Car.new(row) }
  end
end

  cars = CarLoader.get_cars_from_csv("inventory.csv")
  dealership = Dealership.new(cars)
  p dealership.pre(2005)

 if ARGV[0] == "find"
   if ARGV[1] == "all"
     puts  dealership.all
  elsif ARGV[1] == "make"

     puts dealership.find_make(ARGV[2].capitalize)
   elsif ARGV[1] == "pre"
      #print cars made before the year supplied in ARGV[2]
     # puts dealership.pre(ARGV[2])
   elsif ARGV[1] == "post"
      #print cars made after the year supplied in ARGV[2]
   elsif ARGV[1] == "newest"
      puts dealership.newest
   end
 end
