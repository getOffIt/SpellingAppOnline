import Foundation
import SwiftUI

struct LearningView: View {
    @Environment(\.colorScheme) var colorScheme  // Access current color scheme (light/dark)
    
    // Updated to track the user input for each incorrect answer
    @State private var userInputs: [String: String] = [:]
    
    @ObservedObject private var spellingTestMetadata: SpellingTestMetadata
    private let homophonesDefinition = WordsData().homophonesDescriptionForLearningView
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
    
    var incorrectAnswers: [String] { //TODO: move this into the helper class maybe?
        spellingTestMetadata.questions.indices.filter { spellingTestMetadata.answers.indices.contains($0) && spellingTestMetadata.answers[$0] != spellingTestMetadata.questions[$0] }.map { spellingTestMetadata.questions[$0] }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(incorrectAnswers, id: \.self) { question in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(question)
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .foregroundColor(.white)
                        if let definition = homophonesDefinition[question] {
                            Text(" : \(definition)")
                                .foregroundColor(.white)
                        }
                            
                        // Use the question to access or update the corresponding user input.
                        TextEditor(text: Binding(
                            get: { self.userInputs[question, default: ""] },
                            set: { self.userInputs[question] = $0 }
                        ))
                        .frame(minHeight: 80)
                        .font(.body)
                        .scrollContentBackground(.hidden) // Hide default background
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(backgroundColor) // Adaptive background
                        )
                        .foregroundColor(Color.black)
                        .font(.body)
                        .fontWeight(.regular)
                        .shadow(radius: 5)
                        .cornerRadius(10)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .padding(.bottom, 20)
                        .autocapitalization(.none)
                    }
                }
                Button("I'm Done") {
                    spellingTestMetadata.testStatus = .spelling
                    spellingTestMetadata.answers = []
                }
                .padding()  // Add padding inside the button for better touch area
                .frame(maxWidth: .infinity)
                .background(Color.secondary)  // Set a background color
                .foregroundColor(.white)  // Set the text color
                .font(.headline)  // Use a larger font size for better readability
                .cornerRadius(10)  // Round the corners of the button
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)  // Add a shadow for depth
                .buttonStyle(PlainButtonStyle())  // Use a plain button style to avoid default button styling
                .padding(.horizontal)
                .padding(.top, 20)
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
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]), startPoint: .top, endPoint: .bottom))
        
    }
    
    private var backgroundColor: Color {
        return Color.white
        if colorScheme == .dark {
            return Color.black.opacity(0.4)
        } else {
            return Color.secondary // White background for light mode
        }
    }
    
}
