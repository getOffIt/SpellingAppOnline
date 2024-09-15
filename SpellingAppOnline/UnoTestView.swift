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
        ZStack {
            VStack(spacing: 20) {
                Text("Uno Game")
                    .font(.largeTitle)
                    Spacer()
                if spellingTestMetadata.questions.count < 10 {
                    Section("How many words do you have to do?") {
                        Picker("Word Count", selection: $selectedWordCount) {
                            ForEach(1...spellingTestMetadata.questions.count, id: \.self) { count in
                                Text("\(count)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onAppear {
                            selectedWordCount = min(spellingTestMetadata.questions.count, 1)
                        }
                    }
                } else {
                    Picker("Word Count", selection: $selectedWordCount) {
                        ForEach(1...spellingTestMetadata.questions.count, id: \.self) { count in
                            Text("\(count) words")
                        }
                    }
                    .onAppear {
                        selectedWordCount = min(spellingTestMetadata.questions.count, 1)
                    }
                }
                Button(action: {
                    isPresentingDetailView = true
                }) {
                    Text("Start Uno test")
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .padding()
                        .background(Color.secondary)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
                .sheet(isPresented: $isPresentingDetailView) {
                    DetailView(questions: Array(spellingTestMetadata.questions.prefix(selectedWordCount)), isPresented: $isPresentingDetailView)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .foregroundStyle(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]), startPoint: .top, endPoint: .bottom))
        
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
