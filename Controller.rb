require_relative 'dealership'
require_relative 'cars'
require_relative 'carloader'
require_relative 'view'
require 'csv'

cars = []

cars = CarLoader.get_cars_from_csv("inventory.csv").map{|row| Cars.new(row)}
dealership = Dealership.new(cars)

if ARGV[0] == "find"
  if ARGV[1] == "all"
    View.show_cars(dealership.all_cars)
  elsif ARGV[1] == "make"
    View.show_cars(dealership.find_make(ARGV[2]))
  elsif ARGV[1] == "pre"
    View.show_cars(dealership.all_cars_before_year(ARGV[2]))
  elsif ARGV[1] == "post"
    View.show_cars(dealership.all_cars_after_year(ARGV[2]))
  elsif ARGV[1] == "newest"
    View.show_car(dealership.newest_car)
  end
end
