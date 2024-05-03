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
    
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            switch testStatusFull {
            case .spelling:
                SelfTestView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
                    .tag(0)
            case .reviewing:
                ResultsView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
                    .tag(0)
                Text("Spelling Test")
            case .learning:
                Text("Spelling Test")
                LearningView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
                    .tag(0)
            }
            
            switch testStatusSmall {
            case .spelling:
                SelfTestView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text(remoteConfigLocal.secondTabItemText) }
                    .tag(1)
            case .reviewing:
                ResultsView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text(remoteConfigLocal.secondTabItemText)
                    }
                    .tag(1)
                
            case .learning:
                SelfTestView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
                    .tabItem {
                        Image(systemName: "3.circle")
                        Text(remoteConfigLocal.secondTabItemText)
                    }
                    .tag(1)
            }
        }
    }
}

//            switch testStatusLeo {
//            case .spelling:
//                SelfTestView(testStatus: $testStatusLeo, questions: $questionsLeoFull, answers: $answersLeoFull)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text("Léo test")
//                    }
//                    .tag(1)
//            case .reviewing:
//                ResultsView(testStatus: $testStatusLeo, questions: $questionsLeoFull, answers: $answersLeoFull)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text("Léo test")
//                    }
//                    .tag(1)
//            case .learning:
//                SelfTestView(testStatus: $testStatusLeo, questions: $questionsLeoFull, answers: $answersLeoFull)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text("Léo test")
//                    }
//                    .tag(1)
//            }
//            switch testStatusFrench {
//            case .spelling:
//                SelfTestView(testStatus: $testStatusFrench, questions: $questionsFrench, answers: $answersFrench)
//                    .tabItem {
//                        Image(systemName: "3.circle")
//                        Text("French test")
//                    }
//                    .tag(2)
//            case .reviewing:
//                ResultsView(testStatus: $testStatusFrench, questions: $questionsFrench, answers: $answersFrench)
//                    .tabItem {
//                        Image(systemName: "3.circle")
//                        Text("French test")
//                    }
//                    .tag(2)
//            case .learning:
//                SelfTestView(testStatus: $testStatusFrench, questions: $questionsFrench, answers: $answersFrench)
//                    .tabItem {
//                        Image(systemName: "3.circle")
//                        Text("French test")
//                    }
//                    .tag(2)
//            }

