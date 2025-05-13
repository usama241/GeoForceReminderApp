# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'GeoForceReminderApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GeoForceReminderApp
# pod 'Alamofire', '~> 5.0.0'
#  pod 'SDWebImage'
#  pod 'IQKeyboardManagerSwift'
#  pod 'Loaf'
#  pod 'iOSDropDown'
#  pod 'FittedSheets'
#  pod 'FSPagerView'
#  pod 'SVPinView'
#  pod 'PageControls'
#  pod 'CHIPageControl/Jaloro'
#  pod 'KMPlaceholderTextView', '~> 1.4.0'
#  pod 'SDWebImageSVGCoder'
#  pod 'SVGKit'
#  pod 'lottie-ios'
#  pod 'SwiftKeychainWrapper'
#  pod 'SwiftyRSA'
#  pod 'NVActivityIndicatorView'
#  pod 'JXPageControl', '0.1.5'
#  pod 'XLPagerTabStrip', '~> 9.0'
#  pod 'DSF_QRCode', '~> 16.1.1'
#  pod 'Toast-Swift', '~> 5.0.1'
#  pod 'SwiftConfettiView'

  # Enforce iOS 13.0 deployment target across all pod targets
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
end
