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

            VStack(spacing: 20) {
                Text("Spelling Test")
                    .font(.system(size: 36, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.top) // Add some top padding for spacing

                VStack(spacing: 20) {
                    HStack {
                        Text("WORD \(index + 1) OF \(self.spellingTestMetadata.questions.count)")
                            .foregroundColor(Color.white.opacity(0.7))
                            .font(.subheadline.weight(.heavy))
                        Spacer()
                    }
                    .padding(.horizontal)

                    HStack {
                        Spacer() // To align the button to the center
                        Button(action: {
                            // action for play button
                            playButton()
                        }) {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        .onAppear {
                            playButton()
                        }
                        Spacer() // To align the button to the center
                    }
                    
                    TextField("Type word", text: $typedWord)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .autocapitalization(.none)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .onSubmit {
                            nextButton()
                        }
                        .focused($isInputActive)
                        .padding(.horizontal) // Add horizontal padding for consistency
                    
                    Button(action: {
                        nextButton()
                    }) {
                        Text("Next")
                            .foregroundColor(typedWord.isEmpty ? Color.white.opacity(0.5) : .blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(typedWord.isEmpty ? Color.secondary : Color.white)
                            .cornerRadius(10)
                    }
                    .disabled(typedWord.isEmpty)
                    .padding(.horizontal) // Add horizontal padding for consistency
                }
                .padding(.top, 10) // Add some padding to move the contents slightly down
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]), startPoint: .top, endPoint: .bottom))
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

