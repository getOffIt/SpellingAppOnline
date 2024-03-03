import Foundation
import SwiftUI

struct ResultsView: View {
    @State var score: Double = 50 // Replace with actual score
    @State private var currentTime = Date() // Initializes with the current date and time
    
    @State var completionDate:String = "13 Feb 2024 at 10:34"
    let duration = ""
    @Binding var selfTestCompleted: Bool
    @Binding var answers: [String]
    @Binding var questions: [String]
    @State var correct = 0
    @State var pass = true
    
    init(selfTestCompleted: Binding<Bool>, questions: Binding<[String]>, answers: Binding<[String]>) {
        _selfTestCompleted = selfTestCompleted
        _questions = questions
        _answers = answers
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
                
                Button(action: {
                    // Play again action
                    selfTestCompleted = false
                    answers = []
                }) {
                    Text("Play again")
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
        .padding()
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
