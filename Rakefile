$:.unshift("/Library/RubyMotion/lib")

require 'motion/project'
require 'motion-pixate'
require 'map-kit-wrapper'

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
    pod 'SDSegmentedControl', git: 'https://github.com/rs/SDSegmentedControl.git', tag: '1.0.0'
    pod 'SDWebImage'
  end


  app.frameworks += %w(QuartzCore)

  ##Pixate
  app.pixate.user = 'imran.iansari@gmail.com'
  app.pixate.key  = '1MKTV-N0RC1-LLAG4-14GFO-2OLVI-H8HQD-LIP5E-679D0-HCSLN-UKUTV-0N6LR-L189N-O4NSQ-2LBRP-PGTBE-KK'
  app.pixate.framework = 'vendor/PXEngine.framework'

  ##Bridge
  app.vendor_project('vendor/CYAlert', :static)

=begin
  app.vendor_project('vendor/SDSegmentedControl', :static)
=end


end
