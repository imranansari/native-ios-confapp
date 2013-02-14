class AppDelegate
  attr_accessor :window, :backend

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    url = NSURL.URLWithString("http://macbook.local:3000")
    self.backend = RKObjectManager.managerWithBaseURL(url)
    add_mapping(session_mapping, "session")
    add_mapping(participant_mapping, "participant")
    add_mapping(conference_mapping, "conference")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    storyboard = UIStoryboard.storyboardWithName("iphone", bundle:NSBundle.mainBundle)
    #rootVC = storyboard.instantiateViewControllerWithIdentifier("Main")
    #@window.rootViewController = rootVC

    @window.rootViewController = storyboard.instantiateInitialViewController

    @window.rootViewController.wantsFullScreenLayout = true

    @window.makeKeyAndVisible
    true
  end

  def session_mapping
    @session_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Session)
      mapping.addAttributeMappingsFromDictionary(desc: "desc")
      mapping.addAttributeMappingsFromDictionary(title: "title")
      mapping.addAttributeMappingsFromDictionary(presentation: "presentation")
      mapping.addAttributeMappingsFromDictionary(start: "start")
      mapping.addAttributeMappingsFromDictionary(end: "end")
      mapping.addAttributeMappingsFromDictionary(slot: "slot")
    end
  end

  def participant_mapping
    @participant_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Participant)
      mapping.addAttributeMappingsFromDictionary(name: "name")
      mapping.addAttributeMappingsFromDictionary(bio: "bio")
    end
  end


  def address_mapping
    @address_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Address)
      mapping.addAttributeMappingsFromDictionary(address1: "address1")
    end
  end

  def location_mapping
    @location_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Location)
      mapping.addAttributeMappingsFromDictionary(latitude: "latitude")

      mapping.addPropertyMapping(RKRelationshipMapping.relationshipMappingFromKeyPath("address", toKeyPath:"address", withMapping:address_mapping))
    end
  end

  def conference_mapping
    @conference_mapping ||= begin
      mapping = RKObjectMapping.mappingForClass(Conference)
      mapping.addAttributeMappingsFromDictionary(name: "name")
      mapping.addAttributeMappingsFromDictionary(dateStart: "dateStart")
      mapping.addAttributeMappingsFromDictionary(dateEnd: "dateEnd")

      mapping.addPropertyMapping(RKRelationshipMapping.relationshipMappingFromKeyPath("location", toKeyPath:"location", withMapping:location_mapping))
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
