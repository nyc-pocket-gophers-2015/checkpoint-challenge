require 'csv'

module CarLoader
  def self.get_cars_from_csv(filepath)
     return @cars if @cars
    @cars = CSV.read(filepath, { :headers => true, :header_converters => :symbol}).map { |row| Car.new(row) }
  end
end

class Car
  attr_reader :make, :year, :model, :inventory_number
  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end
end

class Dealership
  include CarLoader
  def initialize(cars = nil)
    @cars = cars || []
  end

  def all!
    all = []
    @cars.each do |car|
      all << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}" + "\n"
    end
    all.join('')
  end

  def find_make(make)

    cars_by_make = []
    @cars.each do |car|
      cars_by_make << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}" + "\n" if car.make == make
    end
    cars_by_make
  end

  # def find_pre(argv_two)
  #   cars_before = []
  #   find_make_years = []
  #   find_make(argv_two).each do |index|
  #     find_make_years << index[0..3]
  #   end
  #   p find_make_years
  #   @cars.each do |car|
  #     cars_before << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}" + "\n" #if car.year <
  #   end
  #   cars_before
  # end

  def find_post

  end

  def newest_car
    cars_by_year = []
    new_car = []
    @cars.each do |car|
      cars_by_year << car.year
    end
    max_year = cars_by_year.max
    @cars.each do |car|
      new_car << "#{car.year} #{car.make} #{car.model} ID: #{car.inventory_number}" + "\n" if car.year == max_year
    end
    new_car
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
dealership.find_make("Honda")



if ARGV[0] == "find"
  if ARGV[1] == "all"
    puts dealership.all!
  elsif ARGV[1] == "make"
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
   # puts dealership.find_pre(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
  elsif ARGV[1] == "newest"
    puts dealership.newest_car

  end
end



