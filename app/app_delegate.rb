class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    puts "test"
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    storyboard = UIStoryboard.storyboardWithName("iphone", bundle:nil)
    rootVC = storyboard.instantiateViewControllerWithIdentifier("Main")

    @window.rootViewController = rootVC
    @window.makeKeyAndVisible
    true
  end
end
