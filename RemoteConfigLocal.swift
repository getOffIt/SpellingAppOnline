//
//  RemoteConfigValues.swift
//  SpellingAppOnline
//
//

import Foundation

class RemoteConfigLocal: ObservableObject {
    static let shared = RemoteConfigLocal()
    
    @Published var firsttabItemText = "Year 6D"
}
