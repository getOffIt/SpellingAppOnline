//
//  SpellingTestMetadata.swift
//  SpellingAppOnline
//
//

import Foundation
import SwiftUI

class SpellingTestMetadata: ObservableObject, Identifiable, Hashable {
    
    static func == (lhs: SpellingTestMetadata, rhs: SpellingTestMetadata) -> Bool {
        return lhs.questions == rhs.questions
    }
    
    func hash(into hasher: inout Hasher) {
          hasher.combine(testTitle)
          hasher.combine(questions)
      }
    
    @Published var testStatus: TestStatus = .spelling
    @Published var answers: [String] = []
    @Published var duration = ""
    let testTitle: String
    let questions: [String]
    var startTest: Date = Date()
    var finishTest: Date = Date() {
        didSet {
            calculateDuration()
        }
    }
    
    init(testTitle: String = "", questions: [String]) {
        self.testTitle = testTitle
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

