# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FourSquareClone_Parse' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'Parse'
pod 'RxSwift'

  # Pods for FourSquareClone_Parse

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "11.0"
    end
  end
end