class Conference
  attr_accessor :name, :desc,  :dateStart, :dateEnd, :location


  def initialize(attributes = {})
    self.location = []

    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

end