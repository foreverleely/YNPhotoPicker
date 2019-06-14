#
#  Be sure to run `pod spec lint YNPhotoPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "YNPhotoPickerManager"
  spec.version      = "1.0.6"
  spec.summary      = "help for imagepicker in caream or photo library"

  spec.description  = "auth, caream, album, help these"

  spec.homepage     = "https://github.com/foreverleely/YNPhotoPickerManager"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "liyangly" => "foreverleely@hotmail.com" }
  
  spec.platform     = :ios, "8.0"

  spec.source       = { :git => "https://github.com/foreverleely/YNPhotoPickerManager.git", :tag => "#{spec.version}" }

  spec.source_files  = "YNPhotoPickerManager/*.{h,m}"

  spec.frameworks = "Photos", "UIKit", "Foundation"

end
