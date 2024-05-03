import Foundation
import AVFoundation

class Speech {
    private var synthesizer = AVSpeechSynthesizer()
    private var previousWord: String = ""
    
    func say(word: String) {
        
        previousWord = word
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Junior-compact")
        print("\(word)")
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    func sayThatWordAgain() {
        say(word: previousWord)
    }
}

