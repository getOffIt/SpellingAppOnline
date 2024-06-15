import SwiftUI

struct ResultsViewShare: View {
    let score: Double
    let pass: Bool
    let correctAnswers: Int
    let questions: [String]
    let answers: [String]
    let completionDate: String
    
    private let columns = [
        GridItem(.fixed(120), alignment: .leading),
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.fixed(50), alignment: .center)
    ]
    
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
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(zip(questions.indices, questions)), id: \.0) { index, question in
                    HStack {
                        Text("\(index + 1). \(question)")
                        Spacer()
                    }
                    HStack {
                        Text(answers[index])
                        Spacer()
                    }
                    HStack {
                        Image(systemName: answers[index] == questions[index] ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(answers[index] == questions[index] ? .green : .red)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct ResultsViewShare_Previews: PreviewProvider {
    static var previews: some View {
        ResultsViewShare(score: 66.0, pass: false, correctAnswers: 6, questions: ["bruise", "cemetery", "desperate", "guarantee", "nuisance", "privilege", "queue", "restaurant", "shoulder"], answers: ["bruise", "cemetery", "desperate", "guaranteeee", "nuisance", "privildege", "queue", "restaurant", "shoulderr"], completionDate: "2024-06-15")
    }
}
