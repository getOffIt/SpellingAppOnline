import Foundation
import SwiftUI
import AVFoundation

struct UnoGameView: View {
    var speech: Speech = Speech()
    @State private var currentWordIndex = 0
    @State private var buttonLabel = "Start"
    @State private var selectedWordCount = 1
    @State private var spokenWords: [String] = []
    private var words = WordsData().wordsNotMastered


    var body: some View {
        VStack {
            Picker("Word Count", selection: $selectedWordCount) {
                ForEach(1...words.count, id: \.self) { count in
                    Text("\(count) words")
                }
            }
            .onAppear {
                selectedWordCount = min(self.words.count, 1)
            }
            .padding()
            .font(.headline)
            .pickerStyle(.automatic)
            .accentColor(.blue)
            
            Button(buttonLabel) {
                sayWordList(listOfWords: words)
                buttonLabel = "Next word"
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            
            Text("Only \(words.count - currentWordIndex) words left to learn to win £100")
                .font(.headline)
                .padding()
            
            Text("\(selectedWordCount) words selected")
                .font(.headline)
                .padding()
            
            Button("Repeat Word") {
                speech.sayThatWordAgain()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            
            Button("Reset") {
                reset()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.red) // Changed to red to differentiate from the Repeat button
            .cornerRadius(10)
            
            List(spokenWords, id: \.self) { word in
                Text(word)
            }
            .padding()
        }
    }

    func reset() {
        currentWordIndex = 0
        selectedWordCount = min(self.words.count, 1)
        buttonLabel = "words"
        spokenWords = []
    }

    func sayWordList(listOfWords: Array<String>) {
        if currentWordIndex < listOfWords.count {
            let word = listOfWords[currentWordIndex]
            speech.say(word: word)
            currentWordIndex += 1
            selectedWordCount -= 1
            spokenWords.append(word)
        }
    }

}
