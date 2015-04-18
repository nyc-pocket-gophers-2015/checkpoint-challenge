class Dealership

  attr_reader :cars

  def initialize(cars = nil)
    @cars = cars || []
  end

  def find_make(make)
    cars.select{|obj| obj.make == make}
  end

  def all_cars
    cars
  end

  def all_cars_before_year(year)
    cars.select{|obj| obj.year < year}
  end

  def all_cars_after_year(year)
    cars.select{|obj| obj.year > year}
  end

  def newest_car
    cars.sort_by{|obj| obj.year}.last
  end

end
