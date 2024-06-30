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
    
    
    @Published var firsttabItemText = "Year 6"
    @Published var firsttabItemWordList: [String] = WordsData().latest15June2024
    @Published var secondTabItemText = "Words to master"
    @Published var secondTabItemWordList: [String] = WordsData().wordsNotMastered
    @Published var sharingResultsEnabled = false
    @Published var debugMode = false
    @Published var elevenlabsvoices = false
    @Published var homophonesDescription: [String: String] = WordsData().Homophones
    @Published var enableRemoteHomophones = true
    @Published var testCrash = false
    @Published var introduceTabBar = true
    
    init() {
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
        setRemoteConfigSettings()
        setupRemoteConfigDefaults()
        fetchRemoteConfig()
        remoteConfig?.addOnConfigUpdateListener(remoteConfigUpdateCompletion: {_, _ in} )
    }
    
    func setRemoteConfigSettings() {
        let settings = RemoteConfigSettings()
        remoteConfig?.configSettings = settings
    }
    
    func applyRemoteConfig() {
        self.remoteConfig!.activate { (changed, error) in
            if let error = error {
                print("An error occurred: \(error)")
            } else {
                print("Remote config successfully fetched and activated")
                print(self.remoteConfig ?? "")
                DispatchQueue.main.async {
                    self.firsttabItemText = self.remoteConfig!["firsttabItemText"].stringValue ?? "Year 6"
                    self.firsttabItemWordList = self.remoteConfig!["firsttabItemWordList"].jsonValue as? [String] ?? WordsData().allWordsYear6Part2
                    self.secondTabItemText = self.remoteConfig!["secondTabItemText"].stringValue ?? "Words to master"
                    self.secondTabItemWordList = self.remoteConfig!["secondTabItemWordList"].jsonValue as? [String] ?? WordsData().wordsNotMastered
                    self.sharingResultsEnabled = self.remoteConfig!["sharingResultsEnabled"].boolValue
                    self.debugMode = self.remoteConfig!["debugMode"].boolValue
                    self.elevenlabsvoices = self.remoteConfig!["elevenlabsvoices"].boolValue
                    self.homophonesDescription = self.remoteConfig!["homophonesDescription"].jsonValue as? [String: String] ?? WordsData().Homophones
                    self.enableRemoteHomophones = self.remoteConfig!["enableRemoteHomophones"].boolValue
                    self.testCrash = self.remoteConfig!["testCrash"].boolValue
                    self.introduceTabBar = self.remoteConfig!["introduceTabBar"].boolValue


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
    
}
