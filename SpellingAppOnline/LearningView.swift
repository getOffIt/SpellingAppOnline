import Foundation
import SwiftUI

struct LearningView: View {
    
    // Updated to track the user input for each incorrect answer
    @State private var userInputs: [String: String] = [:]
    
    @ObservedObject private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
    
    var incorrectAnswers: [String] { //TODO: move this into the helper class maybe?
        spellingTestMetadata.questions.indices.filter { spellingTestMetadata.answers.indices.contains($0) && spellingTestMetadata.answers[$0] != spellingTestMetadata.questions[$0] }.map { spellingTestMetadata.questions[$0] }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(incorrectAnswers, id: \.self) { question in
                    Text(question)
                    // Use the question to access or update the corresponding user input.
                    TextEditor(text: Binding(
                        get: { self.userInputs[question, default: ""] },
                        set: { self.userInputs[question] = $0 }
                    ))
                    .frame(minHeight: 80)
                    .border(Color.gray, width: 1)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .padding(.bottom, 20)
                }
                Button("I'm Done") {
                    spellingTestMetadata.testStatus = .spelling
                    spellingTestMetadata.answers = []
                }
            }
            .padding()
            .onAppear {
                // Ensures userInputs dictionary is populated for all incorrect answers when the view appears.
                incorrectAnswers.forEach { question in
                    if userInputs[question] == nil {
                        userInputs[question] = ""
                    }
                }
            }
        }
    }
}
