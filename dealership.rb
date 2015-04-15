require 'pry'
require 'CSV'
require 'byebug'

module Parser
  def import_csv(filepath)
    config = {headers: true, header_converters: :symbol}
    CSV.read(filepath, config).map { |row| row.to_hash }
  end
end

class Car
  # I need to encapsulate these objects inside the dealership...
  def initialize(attributes)
    @inventory_number = attributes[:inventory_number]
    @make = attributes[:make]
    @model = attributes[:model]
    @year = attributes[:year]
  end
end

class Dealership
  include Parser

  attr_accessor :car_filepath, :cars

  def initialize(car_filepath)
    @car_filepath = car_filepath
    @cars = import_csv(car_filepath)
  end

  def find_attribute(att)
    p "Which #{att} are you looking for?"
    specific_att = gets.chomp
    cars.each do |car|
      print_car(car) if car[att.to_sym] == specific_att
    end
  end

  def print_car(car)
    car.each { |k,v| print "#{k}: #{v}, "}
    puts
  end

  def list_cars
    cars.each { |car| print_car(car) }
  end

  def newest_car
    year_cars = cars.map { |car| car[:year] = car[:year].to_i; car }
    year_cars.sort_by!{|car| car[:year] }[-1]
  end
end

dealership = Dealership.new('inventory.csv')

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

binding.pry
