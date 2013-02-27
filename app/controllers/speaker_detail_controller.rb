class SpeakerDetailController < UIViewController
  extend IB
  attr_accessor :model

  outlet :participant_bio, UITextView

  def viewDidLoad
    self.title = self.model.name
    puts "test"
    puts self.model.bio
    puts self.model.pic_file_name
    self.participant_bio.text = self.model.bio

  end

end