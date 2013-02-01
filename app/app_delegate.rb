class AppDelegate
  attr_accessor :window, :backend

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    url = NSURL.URLWithString("http://example_server.dev")
    self.backend = RKObjectManager.managerWithBaseURL(url)
    add_mapping(person_mapping, "person")
    add_mapping(person_mapping, "people")

    puts "test"
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    storyboard = UIStoryboard.storyboardWithName("iphone", bundle:NSBundle.mainBundle)
    #rootVC = storyboard.instantiateViewControllerWithIdentifier("Main")
    #@window.rootViewController = rootVC

    @window.rootViewController = storyboard.instantiateInitialViewController

    @window.rootViewController.wantsFullScreenLayout = true

    @window.makeKeyAndVisible
    true
  end

  def person_mapping
    @person_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Person)
      mapping.addAttributeMappingsFromDictionary(id: "remote_id",
                                                 name: "name")
    end
  end

  def add_mapping(mapping, path)
    successCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
    descriptor = RKResponseDescriptor.responseDescriptorWithMapping(mapping,
                                                                    pathPattern: nil,
                                                                    keyPath: path,
                                                                    statusCodes: successCodes)
    backend.addResponseDescriptor(descriptor)
  end
end
