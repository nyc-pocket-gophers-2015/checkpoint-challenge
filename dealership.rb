require 'csv'
module CarLoader
  def self.get_cars_from_csv(filepath)
    # The result is being passed to the new dealership.
    # I need to return some useful data from this method...
    car_list = []
    CSV.read(filepath, headers: true, header_converters: :symbol).each do |row|
      car_list << row.to_hash
    end
    car_list
  end
end

# cars = CarLoader.get_cars_from_csv("inventory.csv")
# dealership = Dealership.new(cars)





class Car
  attr_reader :make, :year
  def initialize(arguments = {})
    @inventory_number = arguments[:inventory_number]
    @make = arguments[:make]
    @model = arguments[:model]
    @year = arguments[:year]
  end
end

class Dealership
  include CarLoader

  def initialize(cars = nil)
    @cars = cars || []
  end

  def cars
    car_obj_arr = []
    car_arr = []
    car_ar = []
    @cars.each do |x|
      car_obj_arr << x
    end
    car_obj_arr.each do |x|
      car_arr << x.values
    end
    car_arr.each do |y|
      car_ar << y.flatten.join(" ")
    end
    car_ar.each do |z|
      z
    end
  end

  def car_objects
    return @cars if @cars
    @cars = CarLoader.get_cars_from_csv(filepath).map {|car_attrs| Car.new(car_attrs)}
    p @cars
  end

  def find_make(make)
    cars_by_make = []
    cars_by_m = []
    cars_by = []
    @cars.each do |car|
      cars_by_make << car if car[:make].to_s == make.to_s
    end
    cars_by_make.each do |x|
      cars_by_m << x.values
    end
    cars_by_m.each do |y|
      cars_by << y.flatten.join(" ")
    end
    cars_by.each do |z|
      z
    end
  end

  def newest_car
    newest_car = []
    newest = []
    new_s = []
    car_years = []
    @cars.each do |car|
       car_years << car[:year]
    end
    sorted = car_years.sort
    @cars.each do |carr|
      newest_car << carr if sorted[-1] == carr[:year]
    end
    newest_car.each do |x|
      newest << x.values
    end
    newest.each do |y|
      new_s << y.flatten.join(" ")
    end
    new_s.each do |z|
      z
    end
  end

  def pre(year)
    pr = []
    pre = []
    cars_pre = []
    car_years = []
    pre_years = []
    @cars.each do |car|
       # cars_pre << car if car[:year].to_i < year.to_i
       car_years << car[:year].to_i
     end
     car_years.sort
     car_years.each do |carr|
      pre_years << carr if carr.to_i < year.to_i
    end
    @cars.each do |c|
      cars_pre << c if pre_years.include?(c[:year].to_i)
    end
    cars_pre.each do |x|
      pre << x.values
    end
      pre.each do |y|
        pr << y.flatten.join(" ")
      end
      pr.each do |z|
        z
      end

  end

  def post(year)
    po = []
    post = []
    cars_post = []
    car_years = []
    post_years = []
    @cars.each do |car|
       # cars_pre << car if car[:year].to_i < year.to_i
       car_years << car[:year].to_i
     end
     car_years.sort
     car_years.each do |carr|
      post_years << carr if carr.to_i > year.to_i
    end
    @cars.each do |c|
      cars_post << c if post_years.include?(c[:year].to_i)
    end
    cars_post.each do |x|
      post << x.values
    end
      post.each do |y|
        po << y.flatten.join(" ")
      end
      po.each do |x|
         x
      end
  end

end



cars = CarLoader.get_cars_from_csv("inventory.csv")
dealership = Dealership.new(cars)
# p dealership.find_make("Toyota")
# dealership.post("2000")
if ARGV[0] == "find"
  if ARGV[1] == "all"
    # print all of the cars on Deano's lot
    puts dealership.cars
  elsif ARGV[1] == "make"
    # print cars of the make supplied in ARGV[2]
    puts dealership.find_make(ARGV[2])
  elsif ARGV[1] == "pre"
    # print cars made before the year supplied in ARGV[2]
    puts dealership.pre(ARGV[2])
  elsif ARGV[1] == "post"
    # print cars made after the year supplied in ARGV[2]
    puts dealership.post(ARGV[2])
  elsif ARGV[1] == "newest"
    # print the newest car on the lot
    puts dealership.newest_car
  end
end
