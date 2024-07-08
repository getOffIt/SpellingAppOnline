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
    private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
    
    var body: some View {
        
        VStack {
            Text("Uno Game")
                .font(.largeTitle)
            Picker("Word Count", selection: $selectedWordCount) {
                ForEach(1...spellingTestMetadata.questions.count, id: \.self) { count in
                    Text("\(count) words")
                }
            }
            .onAppear {
                selectedWordCount = min(spellingTestMetadata.questions.count, 1)
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
            .sheet(isPresented: $isPresentingDetailView) {
                DetailView(questions: Array(spellingTestMetadata.questions.prefix(selectedWordCount)), isPresented: $isPresentingDetailView)
            }
        }
        
    }
}


struct DetailView: View {
    var questions: [String]
    @Binding var isPresented: Bool
    
    var body: some View {
        let spellingTestMetadata = SpellingTestMetadata(questions: questions)
        
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
