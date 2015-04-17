require 'csv'

module CarLoader
  def self.get_cars_from_csv(filepath)
    @cars = CSV.read(filepath, { :headers => true, :header_converters => :symbol}).map { |car_object| Car.new(car_object) }
  end
end

class Car
  include CarLoader
  attr_reader :make, :year, :model, :inventory_number
  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  def to_s
    "#{self.year} #{self.make} #{self.model} ID: #{self.inventory_number}" + "\n"
  end
end

class Dealership
  attr_accessor :cars
  def initialize(cars = nil)
    @cars = cars || []
  end

  def save
    CSV.open('inventory.csv',"w") do |csv|
      cars.each do |car|
        csv << [car.to_s]
      end
    end
  end

  def add_car(vehicle)
    cars << vehicle
    save
  end

  def all!
    cars.each { |car| car.to_s }
  end

  def find_make(make)
    cars.select { |car| car.to_s if car.make == make}
  end

  def find_pre(year)
    cars.select { |car| car.to_s if car.year < year }
  end

  def find_post(year)
    cars.select { |car| car.to_s if car.year > year }
  end

  def newest_car
    cars.sort_by { |car| car.year }.last
  end
end






