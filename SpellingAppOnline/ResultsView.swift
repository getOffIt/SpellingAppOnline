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
    
    @State private var screenshot: UIImage? = nil
    @State private var isSharing = false
    
    init(testStatus: Binding<TestStatus>, questions: [String], answers: Binding<[String]>) {
        _testStatus = testStatus
        self.questions = questions
        _answers = answers
    }
    var incorrectAnswers: [String] {
        let currentQuestions = questions
        let currentAnswers = $answers.wrappedValue
        return currentQuestions.enumerated().filter { index, question in
            currentAnswers[index] != question
        }.map { $1 }
    }
    
    var body: some View {
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
                Spacer()
                VStack {
                    Button(action: {
                            self.isSharing = true
                        }) {
                            VStack(spacing: 20) {
                                Text("Share results")
                            }
                        }
                        .sheet(isPresented: $isSharing) {
                            if let screenshot = self.screenshot {
                                ActivityView(activityItems: [screenshot])
                            }
                        }
                        .background(ScreenshotView(onScreenshotCaptured:{ screenshot in
                            // Handle the captured screenshot
                            self.screenshot = screenshot
                        }).onAppear())
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
                
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            if incorrectAnswers.isEmpty {
                continueText = "Play again"
            } else {
                continueText = "Continue to Learn words page"
            }
        }
        .padding()
    }
    
    func didCaptureScreenshot(_ screenshot: UIImage) {
          self.screenshot = screenshot
      }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy 'at' HH:mm" // Set date format as per your requirement
        return formatter
    }
    
    private func calculateScore() -> Double {
        let total = questions.count
        correct = 0
        
        for (index, question) in questions.enumerated() {
            if answers[index] == question {
                correct += 1
            }
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


struct ScreenshotView: UIViewRepresentable {
    let onScreenshotCaptured: (UIImage) -> Void

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
            guard let window = UIApplication.shared.windows.first else { return }
            let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
            let screenshot = renderer.image { (context) in
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }
        onScreenshotCaptured(screenshot) // Call the closure
        }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject {
        var screenshot: UIImage?
    }
}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
    }
}
