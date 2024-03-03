import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var currentWordIndex = 0 // Added state variable to keep track of current word index
    @State private var buttonLabel = "words" // Added state variable for button label
    @State private var spokenWords: [String] = []
    @State private var testCompletedSmall = false
    @State private var testCompletedFull = false
    @State private var testCompletedLeoFull = false
    @State private var questionsSmall: [String] = WordsData().wordsNotMastered
    @State private var answersSmall: [String] = []
    @State private var questionsFull: [String] = WordsData().allWordsString
    @State private var answersFull: [String] = []
    @State private var questionsLeoFull: [String] = WordsData().yearOnewords10
    @State private var answersLeoFull: [String] = []
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            UnoGameView()
//                .tag(0)
//                .tabItem {
//                    Image(systemName: "1.circle")
//                    Text("Uno Game")
//                }
//            if testCompletedSmall {
//                ResultsView(selfTestCompleted: $testCompletedSmall, questions: $questionsSmall, answers: $answersSmall)
//                    .tabItem {
//                        Image(systemName: "3.circle")
//                        Text("Learn")
//                    }
//                    .tag(1)
//            }
//            else {
//                SelfTestView(selfTestCompleted: $testCompletedSmall, questions: $questionsSmall, answers: $answersSmall)
//                    .tabItem {
//                        Image(systemName: "3.circle")
//                        Text("Re-Learn")
//                    }
//                    .tag(1)
//            }
            if testCompletedFull {
                ResultsView(selfTestCompleted: $testCompletedFull, questions: $questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Full test")
                    }
                    .tag(0)
            }
            else {
                SelfTestView(selfTestCompleted: $testCompletedFull, questions: $questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text("Full test")
                    }
                    .tag(0)
            }
            if testCompletedLeoFull {
                ResultsView(selfTestCompleted: $testCompletedLeoFull, questions: $questionsLeoFull, answers: $answersLeoFull)
                    .tabItem {
                        Image(systemName: "4.circle")
                        Text("Léo test")
                    }
                    .tag(1)
            }
            else {
                SelfTestView(selfTestCompleted: $testCompletedLeoFull, questions: $questionsLeoFull, answers: $answersLeoFull)
                    .tabItem {
                        Image(systemName: "4.circle")
                        Text("Léo test")
                    }
                    .tag(1)
            }
//            OralTestView()
//                .tabItem {
//                    Image(systemName: "2.circle")
//                    Text("Oral test")
//                }

        }
    }
    
    
}
