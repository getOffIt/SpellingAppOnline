import SwiftUI
import AVFoundation

enum TestStatus {
    case spelling, reviewing, learning
}

struct ContentView: View {
    @State private var selectedTabDebug = 0
    @EnvironmentObject var tabSelection: TabSelection

    
    @ObservedObject var remoteConfigLocal = RemoteConfigManager.shared
    
    @State private var testFull = SpellingTestMetadata(questions:RemoteConfigManager.shared.firsttabItemWordList)
    @State private var testUnoProd = SpellingTestMetadata(questions:RemoteConfigManager.shared.firsttabItemWordList)
    @State private var testUno = SpellingTestMetadata(questions:WordsData().testDataShort)
    @State private var resultsTest = SpellingTestMetadata(questions: WordsData().testDataShort)
    @State private var learningTest = SpellingTestMetadata(questions: WordsData().testDataShort)
    
    private var enableTabBarForDebug = false
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
                TabView(selection: $selectedTabDebug) {
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
                    Button("Crash") {
                        fatalError("Crash was triggered")
                    }.tabItem { Text("Crash") }
                }
            }
        else {
            if RemoteConfigManager.shared.introduceTabBar {
                TabView(selection: $tabSelection.selectedTab) {
                    FullTestSequence(spellingTestMetadata: testFull)
                        .tabItem { Image(systemName: "1.circle"); Text(RemoteConfigManager.shared.firsttabItemText) }.tag(0)
                    UnoTestView(spellingTestMetadata: testUnoProd)
                        .tabItem { Image(systemName: "2.circle"); Text(RemoteConfigManager.shared.secondTabItemText) }.tag(1)
                }
            }
            else {
                FullTestSequence(spellingTestMetadata: testFull)
            }
        }
    }
}
