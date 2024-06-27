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
    @State private var spellingTestMetadata: SpellingTestMetadata
    @State private var temporaryunoTestMetadata: SpellingTestMetadata
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
        self.temporaryunoTestMetadata = SpellingTestMetadata(questions: spellingTestMetadata.questions)
    }
    
    var body: some View {
        
        VStack {
            Text("Uno mode")
                .font(.largeTitle)
            Picker("Word Count", selection: $selectedWordCount) {
                ForEach(1...spellingTestMetadata.questions.count, id: \.self) { count in
                    Text("\(count) words")
                }
            }
            .onAppear {
                selectedWordCount = min(spellingTestMetadata.questions.count, 1)
            }
            .onSubmit {

            }
            Button(action: {
                let reducedQuestions: [String] = reduceArray(spellingTestMetadata.questions, to: selectedWordCount)
                temporaryunoTestMetadata = SpellingTestMetadata(questions: reducedQuestions)
                isPresentingDetailView = true
            }) {
                Text("Start Uno test")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isPresentingDetailView) {
                DetailView(spellingTestMetadata: temporaryunoTestMetadata, isPresented: $isPresentingDetailView)
            }
        }
        
    }
    
    func reduceArray<T>(_ array: [T], to count: Int) -> [T] {
        return Array(array.prefix(count))
    }
}


struct DetailView: View {
    @Binding var isPresented: Bool
    @State private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata, isPresented: Binding<Bool>) {
        self.spellingTestMetadata = spellingTestMetadata
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
        FullTestSequence(spellingTestMetadata: spellingTestMetadata)
    }
}
