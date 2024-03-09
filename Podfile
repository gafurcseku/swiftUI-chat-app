# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'SwiftUI-Chat-App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftUI-Chat-App

  pod 'Alamofire'
  
  #Alamofire request & response logger
  pod 'AlamofireEasyLogger'
  
  #Colorful, flexible, lightweight logging
  pod 'SwiftyBeaver'
  
  #Socket.IO-client for iOS
  pod 'Socket.IO-Client-Swift', '~> 16.0.1'
  
  pod 'Starscream', '4.0.4'
  # End of Pods for SwiftUI-Chat-App
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "11.0"
    end
  end
end
