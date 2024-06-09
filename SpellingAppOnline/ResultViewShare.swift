import Foundation
import SwiftUI

struct ResultsViewShare: View {
    let score: Double
    let pass: Bool
    let correctAnswers: Int
    let questions: [String]
    let answers: [String]
    let completionDate: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("SCORE")
                        .fontWeight(.bold)
                    Text("\(Int(score))%").foregroundColor(pass ? .green : .red)
                    Text("\(correctAnswers)/\(questions.count)").foregroundColor(pass ? .green : .red)
                }
                Spacer()
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
    }
}

