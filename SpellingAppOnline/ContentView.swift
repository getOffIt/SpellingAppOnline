import SwiftUI
import AVFoundation


enum TestStatus {
    case spelling, reviewing, learning
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    @ObservedObject var remoteConfigLocal = RemoteConfigManager.shared
    
    // Main test for Chloe
    @State private var testCompletedFull = false
    @State private var testNeedsLearning = false
    @State private var testStatusFull = TestStatus.spelling
    @State private var answersFull: [String] = []
    private var questionsFull: [String] {get {RemoteConfigManager.shared.firsttabItemWordList}}
//        private var questionsFull = WordsData().testDataShort
    // Small tests for words not mastered Legacy
    @State private var testCompletedSmall = false
    @State private var testStatusSmall = TestStatus.learning
    @State private var answersSmall: [String] = []
    private var questionsSmall: [String] {get {RemoteConfigManager.shared.secondTabItemWordList}}
    
    
    // French test Chloe
    @State private var testCompletedFrench = false
    @State private var testStatusFrench = TestStatus.learning
    @State private var questionsFrench: [String] = WordsData().wordsFrench
    @State private var answersFrench: [String] = []
    
    // Leo's test
    @State private var testCompletedLeoFull = false
    @State private var testStatusLeo = TestStatus.learning
    @State private var questionsLeoFull: [String] = WordsData().yearOnewords10
    @State private var answersLeoFull: [String] = []
    
    private var enableTabBarForDebug = false
    @State private var testStatusResultsDebug = TestStatus.reviewing
    @State private var testStatusResultsDebugQuestions: [String] = WordsData().allWordsYear6Part1
    @State private var testStatusResultsDebugAnswers: [String] = WordsData().allWordsYear6Part1DebugResponses
    
    var body: some View {
        if RemoteConfigManager.shared.debugMode && enableTabBarForDebug {
            TabView(selection: $selectedTab) {
                ResultsView(testStatus: $testStatusFull, questions: testStatusResultsDebugQuestions, answers: $testStatusResultsDebugAnswers)
                    .tabItem {
                        Text("Results")
                    }
                switch testStatusFull {
                case .spelling:
                    SelfTestView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                        .tabItem {
                            Text(remoteConfigLocal.firsttabItemText)
                        }
                case .reviewing:
                        ResultsView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                            .tabItem {
                                Text(remoteConfigLocal.firsttabItemText)
                            }
                case .learning:
                    Text("Spelling Test")
                    LearningView(testStatus: $testStatusResultsDebug, questions: questionsFull, answers: $answersFull)
                        .tabItem {
                            Text(remoteConfigLocal.firsttabItemText)
                        }
                }
            }
        }
        else {
            switch testStatusFull {
            case .spelling:
                SelfTestView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
            case .reviewing:
                    ResultsView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                        .tabItem {
                            Image(systemName: "1.circle")
                            Text(remoteConfigLocal.firsttabItemText)
                        }
            case .learning:
                Text("Spelling Test")
                LearningView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
            }
        }
    }
}
