# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end

target 'Focus' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Focus
  pod 'SnapKit', '~> 5.0.1'
  pod 'LayoutHelper'
  pod "VisualEffectView"

end
