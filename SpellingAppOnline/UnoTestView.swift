//
//  UnoTestView.swift
//  SpellingAppOnline
//
//

import Foundation
import SwiftUI

struct UnoTestView: View {
    @State private var isPresentingDetailView = false
    
    @State private var selectedWordCount = 1
    @Binding var testStatus: TestStatus
    @Binding var answers: [String]
    var questions: [String]
    
    init(testStatus: Binding<TestStatus>, questions: [String], answers: Binding<[String]>) {
        _testStatus = testStatus
        self.questions = questions
        _answers = answers
    }
    
    var body: some View {
        
        VStack {
            Text("Uno mode")
                .font(.largeTitle)
            Picker("Word Count", selection: $selectedWordCount) {
                ForEach(1...questions.count, id: \.self) { count in
                    Text("\(count) words")
                }
            }
            .onAppear {
                selectedWordCount = min(self.questions.count, 1)
            }
            Button(action: {
                isPresentingDetailView = true
            }) {
                Text("Start Uno test")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $isPresentingDetailView) {
            let reducedQuestions = reduceArray(questions, to: selectedWordCount)
            DetailView(testStatus: $testStatus, questions: reducedQuestions, answers: $answers, isPresented: $isPresentingDetailView)
        }
    }
    
    func reduceArray<T>(_ array: [T], to count: Int) -> [T] {
        return Array(array.prefix(count))
    }
}


struct DetailView: View {
    @Binding var isPresented: Bool
    @Binding var testStatus: TestStatus
    @Binding var answers: [String]
    var questions: [String]
    
    init(testStatus: Binding<TestStatus>, questions: [String], answers: Binding<[String]>, isPresented: Binding<Bool>) {
        _testStatus = testStatus
        self.questions = questions
        _answers = answers
        _isPresented = isPresented
    }
    
    var body: some View {
        VStack {
            // Dismiss button handled in the presenting view
            Button(action: {
                isPresented = false
            }) {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                                         .font(.title)
                                         .foregroundColor(.gray)
                                         .padding()
            }
        }
        FullTestSequence(testStatus: $testStatus, answers: $answers, questions: questions)
    }
}
