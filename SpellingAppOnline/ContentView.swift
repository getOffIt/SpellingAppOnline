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
    
    private var enableTabBarForDebug = true
    @State private var testStatusResultsDebug = TestStatus.reviewing
    @State private var testStatusResultsDebugQuestions: [String] = WordsData().allWordsYear6Part1
    @State private var testStatusResultsDebugAnswers: [String] = WordsData().allWordsYear6Part1DebugResponses
    
    init() {
        if RemoteConfigManager.shared.debugMode {
            resultsTest.answers = ["a", "b"]
            resultsTest.startTest = Date()
            resultsTest.finishTest = Date().addingTimeInterval(60)
            learningTest.answers = ["bla", "bla"]
        }
    }
    
    var body: some View {
        if RemoteConfigManager.shared.debugMode && enableTabBarForDebug {
            TabView(selection: $selectedTabDebug) {
                YearViewProgress()
                    .tabItem {
                        Text("Progress")
                    }
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
                    if RemoteConfigManager.shared.yearViewToggle {
                        YearViewProgress()
                        .tabItem { Image(systemName: "3.circle"); Text("Progress") }.tag(2)
                    }
                }
            }
            else {
                FullTestSequence(spellingTestMetadata: testFull)
            }
        }
    }
}
