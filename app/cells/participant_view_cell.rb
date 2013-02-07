class ParticipantViewCell< UITableViewCell
  extend IB

  outlet :participant_name_label, UILabel
  outlet :participant_pic, UIImageView

  def setupCell(participant)
    puts participant.name
    self.participant_name_label.text = participant.name

=begin
    image = UIImage.imageNamed("twitter.png")
    self.participant_pic.image = image
=end

    self.participant_pic.setImageWithURL("http://placehold.it/20x20.png")


=begin
    adore_image = UIImage.imageNamed("twitter.png")
    @adoreImageView = UIImageView.alloc.initWithImage(adore_image)
    @adoreImageView.setFrame(CGRectMake(225, 75, 30, 30))
    @adoreImageView.layer.zPosition = 1
    self.addSubview(@adoreImageView)
=end

  end
end