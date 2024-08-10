import Foundation
import SwiftUI
import AVFoundation

import SwiftUI

struct SelfTestView: View {
    

    var speech: Speech = Speech.shared
    @State private var typedWord: String = ""
    @State private var index = 0
    @FocusState private var isInputActive: Bool
    
    @ObservedObject private var spellingTestMetadata: SpellingTestMetadata
    
    init(spellingTestMetadata: SpellingTestMetadata) {
        self.spellingTestMetadata = spellingTestMetadata
    }
        
    var body: some View {
        ZStack {
            // Invisible button to dismiss the keyboard
                      Color.clear
                          .contentShape(Rectangle())
                          .onTapGesture {
                              isInputActive = false
                          }
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
                        Text("WORD \(index + 1) OF \(self.spellingTestMetadata.questions.count)")
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
                    .onAppear {
                        playButton()
                    }
                    
                    TextField("Type word", text: $typedWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
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
            }
        }
    }
    
    private func playButton() {
        if index == 0 {
            spellingTestMetadata.startTest = Date()
        }
        var homophones = WordsData().Homophones;
        if RemoteConfigManager.shared.enableRemoteHomophones {
            homophones = RemoteConfigManager.shared.homophonesDescription
        }
        let word = self.spellingTestMetadata.questions[index]
        
        if let description = homophones[word] {
            speech.say(word: "\(word) \(description)")
        }
        else {
            speech.say(word: word)
        }
    }
    
    private func nextButton() {
        let trimmedWord = typedWord.trimmingCharacters(in: .whitespaces)
        self.spellingTestMetadata.answers.append(trimmedWord)

        if index == self.spellingTestMetadata.questions.count - 1 {
            spellingTestMetadata.finishTest = Date()
            self.spellingTestMetadata.testStatus = .reviewing
            return
        }
        index += 1
        typedWord = ""
        playButton()
        isInputActive = true
    }
}

