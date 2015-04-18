class Cars

  attr_reader :inventory_number, :make, :model, :year

  def initialize(args)
    @inventory_number = args[:inventory_number]
    @make = args[:make]
    @model = args[:model]
    @year = args[:year]
  end

  def to_s
    puts "#{year} #{make} #{model}, ID: #{inventory_number}"
  end

end
