class AgendaDetailController < UIViewController

  extend IB
  attr_accessor :model


  def viewDidLoad
    self.title = self.model.title
    @composeViewController = REComposeViewController.alloc.init

=begin
    segmentedControlAppearance = SDSegmentedControl.appearance

    segmentedControlAppearance.backgroundColor = UIColor.redColor
    segmentedControlAppearance.borderColor = UIColor.greenColor
    segmentedControlAppearance.arrowSize = 10
    segmentedControlAppearance.arrowHeightFactor = 2.0
=end


  end

  def showQuestionModal sender
    self.modalPresentationStyle = UIModalPresentationCurrentContext


    @composeViewController.navigationItem.leftBarButtonItem.tintColor = UIColor.colorWithRed(97/255.0, green:12/255.0, blue:28/255.0, alpha:1)
    @composeViewController.navigationItem.rightBarButtonItem.tintColor = UIColor.colorWithRed(97/255.0, green:12/255.0, blue:28/255.0, alpha:1)

    @composeViewController.delegate = self
    @composeViewController.title = "Question"
    #@composeViewController.text = "Hi there!"
    self.presentViewController(@composeViewController, animated: true, completion: nil)
    #self.navigationController.presentViewController(@composeViewController, animated: true, completion: nil)
    #self.parentViewController.navigationController.presentViewController(@composeViewController, animated: true, completion: nil)

=begin
    @rootVC = UIApplication.sharedApplication.keyWindow.subviews.objectAtIndex(0, nextResponder)
    puts @rootVC
    @rootVC.presentViewController(@composeViewController, animated: true, completion: nil)
=end

  end

  def composeViewController(composeViewController, didFinishWithResult: result)
    composeViewController.dismissViewControllerAnimated(true, completion: nil)

    if (result == REComposeResultCancelled)
      puts "cancelled"
    end

    if (result == REComposeResultPosted)
      puts composeViewController.text
    end
  end

end