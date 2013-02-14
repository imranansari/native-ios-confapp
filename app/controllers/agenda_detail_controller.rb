class AgendaDetailController < UIViewController
  extend IB

  attr_accessor :model

  outlet :session_desc, UITextView

  def viewDidLoad
    self.title = self.model.title
    self.session_desc.text = self.model.desc


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


    @composeViewController.navigationItem.leftBarButtonItem.tintColor = UIColor.colorWithRed(97/255.0, green: 12/255.0, blue: 28/255.0, alpha: 1)
    @composeViewController.navigationItem.rightBarButtonItem.tintColor = UIColor.colorWithRed(97/255.0, green: 12/255.0, blue: 28/255.0, alpha: 1)

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

  def showDeck
    #puts self.model.presentation.url
    download_file
  end


  ##Quick Look

  def previewController(controller, previewItemAtIndex: index)
    fileName = "MCoE.pdf/"

    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
    documentsDirectory = paths.objectAtIndex(0)
    filePath = documentsDirectory.stringByAppendingPathComponent(fileName)

    puts filePath
    return NSURL.fileURLWithPath(filePath)
  end

  def numberOfPreviewItemsInPreviewController(controller)
    return 1
  end

  def download_file

    url = NSURL.URLWithString("http://macbook.local:3000//MCoE.pdf")
    request = NSURLRequest.requestWithURL(url)

    fileName = "MCoE.pdf/"

    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
    documentsDirectory = paths.objectAtIndex(0)
    filePath = documentsDirectory.stringByAppendingPathComponent(fileName)

    operation = AFHTTPRequestOperation.alloc.initWithRequest(request)
    operation.outputStream = NSOutputStream.outputStreamToFileAtPath(filePath, append: false)
    operation.start

    operation.setCompletionBlockWithSuccess(
        lambda { |operation, responseObject|
          #result = AFMotion::HTTPResult.new(operation, responseObject, nil)
          puts "downloaded"
          @preview_controller = QLPreviewController.alloc.init
          @preview_controller.dataSource = self
          self.presentViewController(@preview_controller, animated: true, completion: nil)
        },
        failure: lambda { |operation, error|
          #result = AFMotion::HTTPResult.new(operation, nil, error)
          #callback.call(result)
          puts "fail"
        }
    )




  end

end