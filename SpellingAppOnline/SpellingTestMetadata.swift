//
//  SpellingTestMetadata.swift
//  SpellingAppOnline
//
//

import Foundation
import SwiftUI

class SpellingTestMetadata: ObservableObject {
    @Published var testStatus: TestStatus = .spelling
    let questions: [String]
    @Published var answers: [String] = []
    @Published var duration = ""
    var startTest: Date = Date()
    var finishTest: Date = Date() {
        didSet {
            calculateDuration()
        }
    }
    
    init(questions: [String]) {
        self.questions = questions
    }
    
    private func calculateDuration() {
        let elapsedTime = finishTest.timeIntervalSince(startTest)
         
         let dateFormatter = DateComponentsFormatter()
         dateFormatter.allowedUnits = [.minute, .second]
         dateFormatter.unitsStyle = .positional
         dateFormatter.zeroFormattingBehavior = .pad
         
         if let formattedDuration = dateFormatter.string(from: elapsedTime) {
             duration = formattedDuration
         } else {
             duration = ""
         }
    }
}

