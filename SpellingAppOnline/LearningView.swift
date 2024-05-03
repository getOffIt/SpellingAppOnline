import Foundation
import SwiftUI
//againagain-- a space to trigger a build
struct LearningView: View {
    
    
    @Binding var testStatus: TestStatus
    @Binding var answers: [String]
    var questions: [String]
    
    // Updated to track the user input for each incorrect answer
    @State private var userInputs: [String: String] = [:]
    
    init(testStatus: Binding<TestStatus>, questions: [String], answers: Binding<[String]>) {
        _testStatus = testStatus
        self.questions = questions
        _answers = answers
    }
    
    var incorrectAnswers: [String] {
        questions.indices.filter { answers.indices.contains($0) && answers[$0] != questions[$0] }.map { questions[$0] }
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
                    .disableAutocorrection(true)
                    .padding(.bottom, 20)
                }
                Button("I'm Done") {
                    testStatus = .spelling
                    answers = []
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
