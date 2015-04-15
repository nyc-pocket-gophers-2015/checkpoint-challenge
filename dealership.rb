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
  attr_reader :inventory_number, :make, :model, :year

  def initialize(attributes)
    @inventory_number = attributes[:inventory_number]
    @make = attributes[:make]
    @model = attributes[:model]
    @year = attributes[:year].to_i
  end

  def to_s
    car_string = ""
    instance_variables.each { |iv| car_string << "#{iv.to_s}: #{self.instance_variable_get(iv)}, " }
    car_string.gsub!(/, $/,"\n")
  end
end

class Dealership
  include Parser

  attr_accessor :car_filepath, :cars

  def initialize(car_filepath)
    @car_filepath = car_filepath
    @cars = convert_to_objects(import_csv(car_filepath))
  end

  def convert_to_objects(array_of_hashes)
    array_of_hashes.map { |car_hash| Car.new(car_hash) }
  end

  def find_make(spec_make)
    cars.select { |car| car.make == spec_make }
  end

  def list_cars
    cars.each { |car| car.to_s }
  end

  def newest_car
    cars.sort_by{ |car| car.year }[-1]
  end

  def list_cars_pre_year(year)
    cars.select{ |car| car.year < year.to_i }
  end

  def list_cars_post_year(year)
    cars.select{ |car| car.year > year.to_i }
  end
end

dealership = Dealership.new('inventory.csv')

if ARGV[0] == "find"
  if ARGV[1] == "all"
    puts "In all their splendor:\n\n"
    puts dealership.list_cars
  elsif ARGV[1] == "make"
    matches = dealership.find_make(ARGV[2])
    puts "'Tis you lucky day as we have #{matches.size} matches!\n\n"
    puts matches
  elsif ARGV[1] == "pre"
    matches = dealership.list_cars_pre_year(ARGV[2])
    puts "Incredible, it seems as if you've have #{dealership.list_cars_pre_year(ARGV[2]).size} matches!\n\n"
    puts matches
  elsif ARGV[1] == "post"
    matches = dealership.list_cars_post_year(ARGV[2])
    puts "Today the world rejoices, for we have obtained #{dealership.list_cars_post_year(ARGV[2]).size} matches! \n\n"
    puts matches
  elsif ARGV[1] == "newest"
    puts "Shiny!\n\n"
    puts dealership.newest_car
  end
end



binding.pry
