class SpeakerDetailController < UIViewController
  extend IB
  attr_accessor :model

  outlet :participant_bio, UITextView
  outlet :participant_pic, UIImageView
  outlet :participant_twitter, UILabel

  def viewDidLoad
    #self.title = self.model.name
    puts "test"
    puts self.model.bio
    puts self.model.pic_file_name
    self.participant_twitter.text = "@iansari"
    self.participant_bio.text = self.model.bio
    self.participant_pic.setImageWithURL(self.model.pic_file_name)

  end

end