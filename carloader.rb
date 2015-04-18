require 'csv'

module CarLoader
  def self.get_cars_from_csv(file)
    carloader_array = []
    CSV.foreach(file, {:headers => true, :header_converters => :symbol}){|row| carloader_array << row.to_hash}
    carloader_array
  end
end
