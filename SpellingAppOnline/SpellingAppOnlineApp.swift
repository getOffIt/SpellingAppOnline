//
//  SpellingAppOnlineApp.swift
//  SpellingAppOnline
//
//build

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var remoteConfig: RemoteConfig? = nil

    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
        setRemoteConfigSettings()
        setupRemoteConfigDefaults()
        fetchAndApplyRemoteConfig()
        return true
    }
    
    func setRemoteConfigSettings() {
        let settings = RemoteConfigSettings()
        #warning("Dev mode for firebase is ON")
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
    }
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            "buttonText": "Default text!" as NSObject,
            "buttonConstraintConstant": 50 as NSObject
        ]
        
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fetchAndApplyRemoteConfig() {
        remoteConfig!.fetch {(status, error) in
            switch status {
            case .success:
                self.remoteConfig!.activate { (changed, error) in
                    if let error = error {
                        print("An error occurred: \(error)")
                    } else {
                        print("Remote config successfully fetched and activated")
                    }
                }
            case .noFetchYet:
                if let error = error {
                    print("An error occurred: \(error)")
                }
            case .failure:
                if let error = error {
                    print("An error occurred: \(error)")
                }
            case .throttled:
                if let error = error {
                    print("An error occurred: \(error)")
                }            @unknown default:
                print("placeholder")
            }
        }
    }
}

@main
struct SpellingAppOnlineApp: App {
    //    register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear() {
                
            }
        }
    }
    
    
}
