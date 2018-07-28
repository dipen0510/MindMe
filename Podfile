# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def available_pods
    	pod 'AFNetworking', '~> 3.0'
        pod 'Bolts'
    	pod 'FBSDKCoreKit'
    	pod 'FBSDKShareKit'
    	pod 'FBSDKLoginKit'
        pod 'SVProgressHUD'
        pod 'Stripe'
        pod 'OneSignal'
        pod 'GoogleAnalytics'
end

target 'MindMe' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for MindMe

	available_pods

  target 'MindMeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MindMeUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
