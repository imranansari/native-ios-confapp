class LocationViewController < UIViewController
  include MapKit

  def viewDidLoad
    self.view = UIView.alloc.initWithFrame(tabBarController.view.bounds)
    map = MapView.new
    map.frame = self.view.frame
    map.delegate = self
    region = CoordinateRegion.new([56, 10.6], [3.1, 3.1])
    map.region = region
    # Alternatively use set_region
    # map.set_region(region, :animated => true)
    map.showsUserLocation = true
    self.view.addSubview(map)
    #map.set_zoom_level = 3
    map.shows_user_location = true
  end

end