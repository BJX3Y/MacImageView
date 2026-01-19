# Uncomment the next line to define a global platform for your project
platform :macos, '13.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

target 'ImageViewer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImageViewer
  # Add your pods here
  
  # Example: Authentication
  # pod 'AuthenticationServices', '~> 1.0'
  
  # Example: Networking
  # pod 'Alamofire', '~> 5.0'
  
  # Example: Image loading
  # pod 'Kingfisher', '~> 7.0'
  
  # Example: QR Code
  # pod 'QRCodeReader.swift', '~> 10.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
