class Location
  attr_accessor :latitude, :address, :desc, :longitude

  def initialize(attributes = {})
    self.address = []

    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = self.latitude
    @coordinate.longitude = self.longitude

    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def coordinate; @coordinate; end

end