class AgendaDetailController < UIViewController
  attr_accessor :model


  def viewDidLoad
    self.title = self.model.title
  end

end