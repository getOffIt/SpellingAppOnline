import Foundation
import SwiftUI

struct ResultsView: View {
    @State var score: Double = 50 // Replace with actual score
    @State private var currentTime = Date()
    
    @State var completionDate:String = "13 Feb 2024 at 10:34"
    let duration = ""
    
    @Binding var testStatus: TestStatus
    @Binding var answers: [String]
    var questions: [String]
    
    @State var correct = 0
    @State var pass = true
    var needsLearning: Bool = false
    @State var continueText = ""
    
    init(testStatus: Binding<TestStatus>, questions: [String], answers: Binding<[String]>) {
        _testStatus = testStatus
        self.questions = questions
        _answers = answers
    }
    var incorrectAnswers: [String] {
        questions.indices.filter { answers.indices.contains($0) && answers[$0] != questions[$0] }.map { questions[$0] }
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
                               Text("\(correct)/\(questions.count)")
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
                    
                    if answers.count == questions.count {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(Array(zip(questions.indices, questions)), id: \.0) { index, question in
                                HStack {
                                    Text("\(index + 1). \(question)")
                                    Spacer()
                                }
                                HStack {
                                    Text(answers[index])
                                        .frame(width: 100, alignment: .center)
                                    Spacer()
                                    
                                }
                                HStack {
                                    Image(systemName: answers[index] == questions[index] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(answers[index] == questions[index] ? .green : .red)
                                    
                                }
                            }
//                                .padding(.vertical, 5)
//                                .background(index % 2 == 0 ? Color(UIColor.systemGray6) : Color(UIColor.systemGray5)) // Alternating background colors
//                                .cornerRadius(8) // Rounded corners for background
                            
                        }
                    }
                    
                    Button(action: {
                        // Play again action
                        if incorrectAnswers.isEmpty {
                            testStatus = .spelling
                            answers = []
                        } else {
                            testStatus = .learning
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
                    imageShareTransferable = imageManager.getTransferable(ResultsViewShare(score: calculateScore(), pass: pass, correctAnswers: correct, questions: questions, answers: answers, completionDate: completionDate), scale: displayScale, caption: "My Results")
                }
            }
        
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm"
        return formatter
    }
    
    private func calculateScore() -> Double {
        let total = questions.count
        correct = 0
        if !answers.isEmpty {
            for (index, question) in questions.enumerated() {
                if answers[index] == question {
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
