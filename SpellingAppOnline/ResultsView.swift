import Foundation
import SwiftUI

struct ResultsView: View {
    @State var score: Double = 50 // Replace with actual score
    @State private var currentTime = Date() // Initializes with the current date and time
    
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
    
    //Share related
    @StateObject var imageManager: ImageManager = ImageManager()
    @Environment(\.displayScale) var displayScale
    @State private var imageShareTransferable: ImageManager.ImageShareTransferable?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Results")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("SCORE")
                                    .fontWeight(.bold)
                                Text("\(Int(score))%").onAppear(){ score = calculateScore() }.foregroundColor(pass ? .green : .red)
                                Text("\(correct)/\(questions.count)").foregroundColor(pass ? .green : .red)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("COMPLETED")
                                    .fontWeight(.bold)
                                Text(completionDate).onAppear(){
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
                    
                    HStack {
                        Text("QUESTION")
                        Spacer()
                        Text("RESPONSE").frame(width: 100, alignment: .center)
                        Spacer()
                    }
                    if answers.count == questions.count {
                        ForEach(Array(zip(questions.indices, questions)), id: \.0) { index, question in
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack {
                                        HStack {
                                            Text("\(index + 1).")
                                                .bold()
                                            Text(question)
                                        }
                                    }
                                    Spacer()
                                    
                                    VStack {
                                        Text(answers[index]).frame(alignment: .center)
                                    }
                                    Spacer()
                                    Image(systemName: answers[index] == questions[index] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(answers[index] == questions[index] ? .green : .red)
                                }
                                
                            }
                            .padding(.horizontal)
                        }
                    }
                    Button(action: {
                        // Play again action
                        if (incorrectAnswers.isEmpty) {
                            testStatus = .spelling
                            answers = []
                        }
                        else {
                            testStatus = .learning
                        }
                    }) {
                        Text(continueText)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .padding()
                    if (RemoteConfigManager.shared.sharingResultsEnabled) {
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
                .frame(maxWidth: .infinity)
            }
            .onAppear {
                
                if incorrectAnswers.isEmpty {
                    continueText = "Play again"
                } else {
                    continueText = "Continue to Learn words page"
                }
                if (RemoteConfigManager.shared.sharingResultsEnabled) {
                    imageShareTransferable = imageManager.getTransferable(ResultsViewShare(score: calculateScore(), pass: pass, correctAnswers: correct, questions: questions,answers: answers , completionDate: completionDate), scale: displayScale, caption: "My Results")
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm" // Set date format as per your requirement
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
        }
        else {
            correct = 1 // I've only had this happen when running on the simulator and using the enter key on keyboard when during the spelling test phase
        }
        let percentage = Double(correct) / Double(total) * 100
        if percentage > 89.40 {
            pass = true
        }
        else {
            pass = false
        }
        return percentage
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
