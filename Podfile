# Uncomment the next line to define a global platform for your project
platform :ios, '18.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if Gem::Version.new('18.0') > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '18.0'
      end
    end
  end
end

target 'SpellingAppOnline' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # hide build warnings for Pods
  inhibit_all_warnings!
  
  # Pods for SpellingAppOnline
  pod 'Firebase/AnalyticsWithoutAdIdSupport'
  pod 'Firebase/RemoteConfig'
  pod 'FirebaseCrashlytics'
  pod 'FirebasePerformance'

  target 'SpellingAppOnlineTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SpellingAppOnlineUITests' do
    # Pods for testing
  end

end
