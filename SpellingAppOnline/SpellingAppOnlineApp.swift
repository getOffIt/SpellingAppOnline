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

class TabSelection: ObservableObject {
    @Published var selectedTab: Int = 0
}

@main
struct SpellingAppOnlineApp: App {
    //    register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var tabSelection = TabSelection()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(tabSelection)
                .onChange(of: scenePhase) {oldPhase, newPhase in
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
