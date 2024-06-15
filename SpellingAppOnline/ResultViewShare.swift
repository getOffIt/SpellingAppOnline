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
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("\(Int(score))%")
                        .foregroundColor(pass ? .green : .red)
                        .font(.largeTitle)
                    Text("\(correctAnswers)/\(questions.count)")
                        .foregroundColor(pass ? .green : .red)
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Text("QUESTION")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text("RESPONSE")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 150, alignment: .center)
                Spacer()
                Text("RESULT")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            
            Divider()
            
            if answers.count == questions.count {
                ForEach(Array(zip(questions.indices, questions)), id: \.0) { index, question in
                    VStack {
                        HStack {
                            Text("\(index + 1). \(question)")
                            Spacer()
                            Text(answers[index])
                                .frame(width: 150, alignment: .center)
                            Spacer()
                            Image(systemName: answers[index] == questions[index] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(answers[index] == questions[index] ? .green : .red)
                        }
                        Divider()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

struct ResultsViewShare_Previews: PreviewProvider {
    static var previews: some View {
        ResultsViewShare(score: 66.0, pass: false, correctAnswers: 6, questions: ["bruise", "cemetery", "desperate", "guarantee", "nuisance", "privilege", "queue", "restaurant", "shoulder"], answers: ["bruise", "cemetery", "desperate", "guaranteeee", "nuisance", "privildege", "queue", "restaurant", "shoulderr"], completionDate: "2024-06-15")
    }
}
