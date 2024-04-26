//
//  SpellingAppOnlineApp.swift
//  SpellingAppOnline
//
//build

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

class AppDelegate: NSObject, UIApplicationDelegate {
    var remoteConfigManager = RemoteConfigManager.shared
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Application cold launch

        return true
    }
}

@main
struct SpellingAppOnlineApp: App {
    //    register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView().onChange(of: scenePhase) {oldPhase, newPhase in
                
                switch newPhase {
                case .active:
                    print("active")
                    RemoteConfigManager.shared.applyRemoteConfig()
                    RemoteConfigManager.shared.fetchRemoteConfig()
                case .background:
                    print("background")
                case .inactive:
                    print("inactive")
                @unknown default:
                    print("@unknown default")
                }
            }
        }
    }
    
    
}
