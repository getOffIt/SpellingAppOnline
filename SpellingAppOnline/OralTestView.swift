import Foundation
import SwiftUI
import AVFoundation

struct OralTestView: View {
    private let data = WordsData()
    private let theSections: [YearWordSection]
    var speech: Speech = Speech()
    @State private var index = 0
    @State private var indexAllWords = 0
    @State private var sectionIndex = 0
    @State private var playingSection: String = ""
    @State private var wordsUttered:Set<String> = []
    @State private var buttonFullTest = "Full test"
    
    init() {
        theSections = data.yearWordSection
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(wordsUttered.count) / \(data.count) words, \(data.count - wordsUttered.count) words left")
                Button(buttonFullTest) {
                    fulltest()
                    buttonFullTest = "Next word"
                }   .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            List {
                ForEach(theSections, id: \.title) { aSection in
                    Section(header:
                                HStack {
                        Text(aSection.title)
                        Spacer()
                        Text("Play this section")
                        Button(action: {
                            if playingSection != aSection.title {
                                index = 0
                            }
                            playingSection = aSection.title
                            say(section: aSection.words.map {$0.word})
                            
                        }) {
                            Image(systemName: playingSection == aSection.title ? "arrow.right.circle" : "play.circle")
                                .foregroundColor(playingSection == aSection.title ? .blue : .green)
                        }
                    }) {
                        ForEach(aSection.words, id: \.word) { wordStruct in
                            HStack {
                                Text(wordStruct.word)
                                Spacer()
                                Button(action: {
                                    wordsUttered.insert(wordStruct.word)
                                    speech.say(word: wordStruct.word)
                                }) {
                                    Image(systemName: wordsUttered.contains(wordStruct.word) ? "arrow.right.circle" : "play.circle")
                                }
                                .foregroundColor(wordsUttered.contains(wordStruct.word) ? .blue : .green)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .padding()
        }
    }
    
    func fulltest() {
        if indexAllWords < data.allWords.count {
            let word = data.allWords[indexAllWords]
            wordsUttered.insert(word)
            speech.say(word: word)
            indexAllWords += 1
        }
    }
    
    func say(section: Array<String>) {
        if index < section.count {
            let word = section[index]
            wordsUttered.insert(word)
            speech.say(word: word)
            index += 1
        }
    }
}
