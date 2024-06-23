//
//  FullTestSequence.swift
//  SpellingAppOnline
//
//

import Foundation
import SwiftUI

struct FullTestSequence: View {

    @Binding var testStatus: TestStatus
    @Binding var answers: [String]
    var questions: [String]
    
    var body: some View {
        switch testStatus {
        case .spelling:
            SelfTestView(testStatus: $testStatus, questions: questions, answers: $answers)

        case .reviewing:
                ResultsView(testStatus: $testStatus, questions: questions, answers: $answers)

        case .learning:
            Text("Spelling Test")
            LearningView(testStatus: $testStatus, questions: questions, answers: $answers)
        }
    }
    
}

