import Foundation
import SwiftUI

struct ResultsView: View {
    @State var score: Double = 50 // Replace with actual score
    @State private var currentTime = Date()
    
    @State var completionDate:String = "13 Feb 2024 at 10:34"
    let duration = ""
        
    @State var correct = 0
    @State var pass = true
    var needsLearning: Bool = false
    @State var continueText = ""
    
    @ObservedObject private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
    
    var incorrectAnswers: [String] { //TODO: Maybe move this to the testMedatada class as a helper
        spellingTestMetadata.questions.indices.filter { spellingTestMetadata.answers.indices.contains($0) && spellingTestMetadata.answers[$0] != spellingTestMetadata.questions[$0] }.map { spellingTestMetadata.questions[$0] }
    }
    
    // Share related
    @StateObject var imageManager: ImageManager = ImageManager()
    @Environment(\.displayScale) var displayScale
    @State private var imageShareTransferable: ImageManager.ImageShareTransferable?
    
    // Layout related
    
    private let columns = [
        GridItem(.fixed(120), alignment: .leading),
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.fixed(50), alignment: .center)
    ]
    
    var body: some View {
        
            ScrollView {
               VStack() {
                   Text("Results")
                       .font(.largeTitle)
                       .fontWeight(.bold)
                   
                   VStack(alignment: .leading, spacing: 10) { // Adjusted spacing
                       HStack {
                           VStack(alignment: .leading) {
                               Text("SCORE")
                                   .fontWeight(.bold)
                               Text("\(Int(score))%")
                                   .foregroundColor(pass ? .green : .red)
                                   .onAppear {
                                       score = calculateScore()
                                   }
                               Text("\(correct)/\(spellingTestMetadata.questions.count)")
                                   .foregroundColor(pass ? .green : .red)
                           }
                           Spacer()
                           VStack(alignment: .leading) {
                               Text("COMPLETED")
                                   .fontWeight(.bold)
                               Text(completionDate)
                                   .onAppear {
                                       completionDate = dateFormatter.string(from: currentTime)
                                   }
                           }
                           Spacer()
                           VStack(alignment: .leading) {
                               Text("DURATION")
                                   .fontWeight(.bold)
                               Text(duration)
                           }
                       }
                   }
                   .padding()
                   
                    LazyVGrid(columns: columns, spacing: 10) {
                        Text("QUESTION")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("RESPONSE")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("-")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                   if spellingTestMetadata.answers.count == spellingTestMetadata.questions.count {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(Array(zip(spellingTestMetadata.questions.indices, spellingTestMetadata.questions)), id: \.0) { index, question in
                                HStack {
                                    Text("\(index + 1). \(question)")
                                    Spacer()
                                }
                                HStack {
                                    Text(spellingTestMetadata.answers[index])
                                        .frame(width: 100, alignment: .center)
                                    Spacer()
                                    
                                }
                                HStack {
                                    Image(systemName: spellingTestMetadata.answers[index] == spellingTestMetadata.questions[index] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(spellingTestMetadata.answers[index] == spellingTestMetadata.questions[index] ? .green : .red)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        // Play again action
                        if incorrectAnswers.isEmpty {
                            spellingTestMetadata.testStatus = .spelling
                            spellingTestMetadata.answers = []
                        } else {
                            spellingTestMetadata.testStatus = .learning
                        }
                    }) {
                        Text(continueText)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10) // Enhanced button appearance
                    }
                    .padding()
                    
                    if RemoteConfigManager.shared.sharingResultsEnabled {
                        if let imageShareTransferable = imageShareTransferable {
                            ShareLink(
                                item: imageShareTransferable,
                                preview: SharePreview(
                                    imageShareTransferable.caption,
                                    image: imageShareTransferable.image)) {
                                        HStack {
                                            Image(systemName: "square.and.arrow.up")
                                            Text("Share my Results")
                                        }
                                }
                                  .padding()
                    }
                }
              }
              .padding()
              .frame(maxWidth: .infinity)
            }
            .onAppear {
                if incorrectAnswers.isEmpty {
                    continueText = "Play again"
                } else {
                    continueText = "Continue to Learn words page"
                }
                if RemoteConfigManager.shared.sharingResultsEnabled {
                    imageShareTransferable = imageManager.getTransferable(ResultsViewShare(score: calculateScore(), pass: pass, correctAnswers: correct, questions: spellingTestMetadata.questions.reversed().reversed(), answers: spellingTestMetadata.answers.reversed().reversed(), completionDate: completionDate), scale: displayScale, caption: "My Results")
                }
            }
        
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        return formatter
    }
    
    private func calculateScore() -> Double { //TODO: maybe move this into the SpellingTest metadata class as a helper?
        let total = spellingTestMetadata.questions.count
        correct = 0
        if !spellingTestMetadata.answers.isEmpty {
            for (index, question) in spellingTestMetadata.questions.enumerated() {
                if spellingTestMetadata.answers[index] == question {
                    correct += 1
                }
            }
        } else {
            correct = 1 // I've only had this happen when running on the simulator and using the enter key on keyboard when during the spelling test phase
        }
        let percentage = Double(correct) / Double(total) * 100
        pass = percentage > 89.4
        return percentage
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
