require 'csv'
require_relative 'view.rb'
require_relative 'model_dealership.rb'

class Controller
  attr_accessor :car_lot
  def initialize(car_lot)
    @car_lot = car_lot
  end

  def start
    View.title
    View.options
    inputs
    puts ""
  end

  def inputs
    if ARGV[0] == "add"
      args = ARGV[1..-1]
      p args
      car = {make: args[0], model: args[1], year: args[2]}
      puts car_lot.add_car(Car.new car)
    elsif ARGV[1] == "all"
        puts car_lot.all!
      elsif ARGV[1] == "make"
        puts car_lot.find_make(ARGV[2])
      elsif ARGV[1] == "pre"
       puts car_lot.find_pre(ARGV[2])
      elsif ARGV[1] == "post"
        puts car_lot.find_post(ARGV[2])
      elsif ARGV[1] == "newest"
        puts car_lot.newest_car
    end
  end
end

cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)

controller = Controller.new(dealership)
controller.start
