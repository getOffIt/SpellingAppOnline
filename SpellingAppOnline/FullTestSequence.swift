//
//  FullTestSequence.swift
//  SpellingAppOnline
//
//

import Foundation
import SwiftUI

struct FullTestSequence: View {
    
    @ObservedObject private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
    
    var body: some View {
        switch spellingTestMetadata.testStatus {
        case .spelling:
            SelfTestView(spellingTestMetadata: spellingTestMetadata)
            
        case .reviewing:
            ResultsView(spellingTestMetadata: spellingTestMetadata)
            
        case .learning:
            LearningView(spellingTestMetadata: spellingTestMetadata)
        }
    }
    
}

