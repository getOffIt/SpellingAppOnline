import Foundation
import SwiftUI
import AVFoundation

import SwiftUI

struct SelfTestView: View {
    @Binding var selfTestCompleted: Bool
    @Binding var answers: [String]
    @Binding var questions: [String]

    var speech: Speech = Speech()
    @State private var typedWord: String = ""
    @State private var index = 0
    @FocusState private var isInputActive: Bool
    
    init(selfTestCompleted: Binding<Bool>, questions: Binding<[String]>, answers: Binding<[String]>) {
        _selfTestCompleted = selfTestCompleted
        _questions = questions
        _answers = answers
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Spelling Test")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            VStack {
                HStack {
                    Text("WORD \(index + 1) OF \(questions.count)")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        // action for play button
                        playButton()
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                }
                .padding()
                
                TextField("Type word", text: $typedWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .submitLabel(.next)
                    .onSubmit {
                        nextButton()
                    }
                    .focused($isInputActive)
                
                Button(action: {
                    nextButton()
                }) {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(typedWord.isEmpty ? Color.gray : Color.purple)
                        .cornerRadius(10)
                }
                .disabled(typedWord.isEmpty)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            isInputActive = true
            playButton()
            
        }
    }
    
    private func playButton() {
        let homophones = WordsData().Homophones;
        let word = questions[index]
        
        if let description = homophones[questions[index]] {
            speech.say(word: "\(word) \(description)")
        }
        else {
            speech.say(word: questions[index])
        }
    }
    
    private func nextButton() {
        let trimmedWord = typedWord.trimmingCharacters(in: .whitespaces)
        answers.append(trimmedWord)

        if index == questions.count - 1 {
            selfTestCompleted = true
            return
        }
        index += 1
        typedWord = ""
        playButton()
        isInputActive = true
    }
}
