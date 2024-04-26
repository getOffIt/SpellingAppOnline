//
//  RemoteConfigValues.swift
//  SpellingAppOnline
//
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

class RemoteConfigManager: ObservableObject {
    static let shared = RemoteConfigManager()
    
    var remoteConfig: RemoteConfig? = nil
    
    
    @Published var firsttabItemText = "Year 6D"
    
    
    init() {
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
        setRemoteConfigSettings()
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
    }
    
    func setRemoteConfigSettings() {
        let settings = RemoteConfigSettings()
#warning("Dev mode for firebase is ON")
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
    }
    
    func applyRemoteConfig() {
        self.remoteConfig!.activate { (changed, error) in
            if let error = error {
                print("An error occurred: \(error)")
            } else {
                print("Remote config successfully fetched and activated")
                DispatchQueue.main.async {
                    self.firsttabItemText = self.remoteConfig!["firsttabItemText"].stringValue ?? "meh"
                }
            }
        }
    }
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            "buttonText": "Default text!" as NSObject,
            "buttonConstraintConstant": 50 as NSObject,
            "firsttabItemText": "Year 6" as NSObject
        ]
        
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    
    func fetchRemoteConfig() {
        remoteConfig!.fetch {(status, error) in
            switch status {
            case .success:
                print("Remote config successfully fetched")
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
                }
            @unknown default:
                print("placeholder")
            }
        }
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
                        DispatchQueue.main.async {
                            self.firsttabItemText = self.remoteConfig!["firsttabItemText"].stringValue ?? "meh"
                        }
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
                }
            @unknown default:
                print("placeholder")
            }
        }
    }
}
