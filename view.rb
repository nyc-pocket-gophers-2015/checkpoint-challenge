class View
  def self.title
    puts "*"*25
    puts "CAR DEALERSHIP APP"
    puts "*"*25
  end
  def self.options
    puts ""
    puts "(find all) prints a list of all vehicles registered in the dealership."
    puts "(find make) filters your search by make."
    puts "(find pre year) print a list of all cars before a given year."
    puts "(find post year) same as above but after a given year."
    puts "(find newest) returns the newest car on the lot."
    puts "(add) must provide the year, make, model, and inventory_number"
    puts ""
  end
end