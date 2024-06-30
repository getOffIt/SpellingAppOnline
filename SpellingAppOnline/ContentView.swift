import SwiftUI
import AVFoundation

enum TestStatus {
    case spelling, reviewing, learning
}

struct ContentView: View {
    @State private var selectedTab = 0
    
    @ObservedObject var remoteConfigLocal = RemoteConfigManager.shared
    
    @State private var testFull = SpellingTestMetadata(questions:RemoteConfigManager.shared.firsttabItemWordList)
    @State private var testUno = SpellingTestMetadata(questions:WordsData().testDataShort)
    @State private var resultsTest = SpellingTestMetadata(questions: WordsData().testDataShort)
    @State private var learningTest = SpellingTestMetadata(questions: WordsData().testDataShort)
    
    private var enableTabBarForDebug = true
    @State private var testStatusResultsDebug = TestStatus.reviewing
    @State private var testStatusResultsDebugQuestions: [String] = WordsData().allWordsYear6Part1
    @State private var testStatusResultsDebugAnswers: [String] = WordsData().allWordsYear6Part1DebugResponses
    
    init() {
        resultsTest.answers = ["a", "b"]
        resultsTest.startTest = Date()
        sleep(1)
        resultsTest.finishTest = Date()
        learningTest.answers = ["bla", "bla"]
    }
    
    var body: some View {
        if RemoteConfigManager.shared.debugMode && enableTabBarForDebug {
            if RemoteConfigManager.shared.testCrash {
                Button("Crash") {
                    fatalError("Crash was triggered")
                }
            }
            else {
                TabView(selection: $selectedTab) {
                    FullTestSequence(spellingTestMetadata: testFull)
                        .tabItem {
                            Text(remoteConfigLocal.firsttabItemText)
                        }
                    UnoTestView(spellingTestMetadata: testUno)
                        .tabItem {
                            Text("Uno")
                        }
                    ResultsView(spellingTestMetadata: resultsTest)
                        .tabItem {
                            Text("Results")
                        }
                    LearningView(spellingTestMetadata: learningTest)
                        .tabItem {
                            Text("Learning")
                        }
                }
            }
        }
        
        else {
            FullTestSequence(spellingTestMetadata: testFull)
        }
    }
}
