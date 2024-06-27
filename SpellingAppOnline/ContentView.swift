import SwiftUI
import AVFoundation


enum TestStatus {
    case spelling, reviewing, learning
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    @ObservedObject var remoteConfigLocal = RemoteConfigManager.shared
    
    // Main test for Chloe
    @State private var testStatusFull = TestStatus.spelling
    @State private var answersFull: [String] = []
    private var questionsFull: [String] {get {RemoteConfigManager.shared.firsttabItemWordList}}
    //    private var questionsFull = WordsData().testDataHomophones
    @State private var testStatusUno = TestStatus.spelling
    @State private var answersUno: [String] = []
    //    private var questionsFull = WordsData().testDataHomophones
    
    private var enableTabBarForDebug = false
    @State private var testStatusResultsDebug = TestStatus.reviewing
    @State private var testStatusResultsDebugQuestions: [String] = WordsData().allWordsYear6Part1
    @State private var testStatusResultsDebugAnswers: [String] = WordsData().allWordsYear6Part1DebugResponses
    
    var body: some View {
        if RemoteConfigManager.shared.debugMode && enableTabBarForDebug {
            TabView(selection: $selectedTab) {
                UnoTestView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Text("Uno")
                    }
                ResultsView(testStatus: $testStatusFull, questions: testStatusResultsDebugQuestions, answers: $testStatusResultsDebugAnswers)
                    .tabItem {
                        Text("Results")
                    }
                FullTestSequence(testStatus: $testStatusFull, answers: $answersFull, questions: questionsFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
            }
        }
        else {            
            FullTestSequence(testStatus: $testStatusFull, answers: $answersFull, questions: questionsFull)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text(remoteConfigLocal.firsttabItemText)
                }
        }
    }
}
