class Location
  attr_accessor :latitude, :address

  def initialize(attributes = {})
    self.address = []

    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

end