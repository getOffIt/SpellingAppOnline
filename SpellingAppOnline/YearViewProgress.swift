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
            Text("Year 6 progress is \(progress)%").onAppear(){ progress = CalculateProgress().progressPercentage()}
            Text("You know \(current) words out of \(total)").onAppear(){ current = CalculateProgress().current(); total = CalculateProgress().total()}
        }
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
