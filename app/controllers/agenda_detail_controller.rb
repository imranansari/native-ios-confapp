class AgendaDetailController < UIViewController
  attr_accessor :model


  def viewDidLoad
    self.title = self.model.title

=begin
    segmentedControlAppearance = SDSegmentedControl.appearance

    segmentedControlAppearance.backgroundColor = UIColor.redColor
    segmentedControlAppearance.borderColor = UIColor.greenColor
    segmentedControlAppearance.arrowSize = 10
    segmentedControlAppearance.arrowHeightFactor = 2.0
=end
  end

end