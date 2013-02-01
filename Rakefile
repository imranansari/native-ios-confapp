$:.unshift("/Library/RubyMotion/lib")

require 'motion/project'
require 'bundler'

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.

  app.name = 'ConfApp'

##=begin
  app.identifier = 'HSQ9BG4FTW.com.innovativecloudsolutions.conf'
##app.device_family = :iphone
  app.codesign_certificate = "iPhone Developer: Imran Ansari (P6UPG6M8QU)"
  app.provisioning_profile = "/Users/iansari/Documents/MobileProfiles/ConfApp_Development.mobileprovision"

  #app.icons = ['doll_iphone.png']
  app.prerendered_icon = true

  app.pods do
    pod 'RestKit', git: 'https://github.com/RestKit/RestKit.git', branch: 'development'
  end

end
