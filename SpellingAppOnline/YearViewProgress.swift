//
//  YearViewProgress.swift
//  SpellingAppOnline
//
//

import Foundation

import SwiftUI
//againagain-- a space to trigger a build
struct YearViewProgress: View {
    
    @State var progress = 50
    @State var current = 0
    @State var total = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Text("Year 6: \(CalculateProgress().progressPercentage())%")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Completed")
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            
            ProgressView(value: 4, total: 8)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .padding([.leading, .trailing], 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
    
    
    struct CalculateProgress {
        let currentProgress = WordsData().allWordsYear6Part1.count + WordsData().allWordsYear6Part2.count + WordsData().allWordsYear6Part3.count
        
        func calculate() -> Int {
            return 55
        }
        
        func current() -> Int {
            return currentProgress
        }
        
        func progressPercentage() -> Int {
            let totalWords = total()
            guard totalWords > 0 else { return 0 }
            let progress = current()
            return (progress * 100) / totalWords
        }
        
        func total() -> Int {
            return WordsData().allWordsYear6.count
        }
        
    }
    
    // currently in part 4
    // all words
