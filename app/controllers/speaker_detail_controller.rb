class SpeakerDetailController < UIViewController
  extend IB
  attr_accessor :model

  outlet :participant_bio_label, UILabel

  def viewDidLoad
    self.title = self.model.name
    puts "test"
    puts self.model.bio
    self.participant_bio_label.text = self.model.bio
  end

end