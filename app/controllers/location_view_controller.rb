class LocationViewController < UIViewController
  extend IB

  outlet :locationMap, MKMapView

  def loadView
    self.view = MKMapView.alloc.init
    view.delegate = self
  end

  def viewDidLoad
    view.frame = tabBarController.view.bounds

    lat = App.delegate.conferenceModel.location.latitude
    long = App.delegate.conferenceModel.location.longitude


    region = MKCoordinateRegionMake(CLLocationCoordinate2D.new(lat, long), MKCoordinateSpanMake(3.1, 3.1))
    self.view.setRegion(region)


    subtitle = App.delegate.conferenceModel.location.address.address1 + ", " + App.delegate.conferenceModel.location.address.city + ", "  +App.delegate.conferenceModel.location.address.state

    self.view.addAnnotation(Beer.new(lat, long, subtitle, 'http://en.wikipedia.org/wiki/Chimay_Brewery'))


    self.view.selectAnnotation(self.view.annotations.lastObject, animated:true)
  end



  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:beer)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = beer
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(beer, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop = true
      button = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    view
  end

  def showDetails(sender)
    if view.selectedAnnotations.size == 1
      beer = view.selectedAnnotations[0]
      controller = UIApplication.sharedApplication.delegate.beer_details_controller
      navigationController.pushViewController(controller, animated:true)
      controller.showDetailsForBeer(beer)
    end
  end



end