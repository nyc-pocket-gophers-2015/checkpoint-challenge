class View

  def self.show_cars(cars)
    cars.each{|row| row.to_s}
  end

  def self.show_car(cars)
    cars.to_s
  end

end
