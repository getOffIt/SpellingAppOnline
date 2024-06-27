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
    @State var duration = ""
    var startTest: Date = Date()
    var finishTest: Date = Date()
    
    init(questions: [String]) {
        self.questions = questions
    }
}

