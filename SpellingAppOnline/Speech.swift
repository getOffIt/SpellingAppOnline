import Foundation
import AVFoundation

class Speech {
    private var synthesizer = AVSpeechSynthesizer()
    private var previousWord: String = ""
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        configureAudioSession()
    }
    
    func say(word: String) {
        
        previousWord = word
        
        // Stop any current audio playback when users are typing faster than the word is uttered
        if let player = audioPlayer, player.isPlaying {
            player.stop()
            print("Stopping mp3 for word: \(word)")
        }
                
        do { // AI Generated audio sounds nicer, always try to play first but as I have to generate them in advance they are not always available
            let path = Bundle.main.path(forResource: "\(word).mp3", ofType:nil) ?? ""
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            print("Playing mp3 for word: \(word)")
        } catch { // Otherwise, use system synthetiser
            print("Error loading mp3 file for \(word): \(error.localizedDescription)")
            synthesizeSpeech(word: word)
        }
    }
    
    
    func synthesizeSpeech(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Junior-compact")
        print("\(word)")
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    func sayThatWordAgain() {
        say(word: previousWord)
    }
    
    private func configureAudioSession() {
           let audioSession = AVAudioSession.sharedInstance()
           do {
               try audioSession.setCategory(.playback, mode: .default, options: [])
               try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
           } catch {
               print("Failed to set audio session category. Error: \(error)")
           }
       }
}

