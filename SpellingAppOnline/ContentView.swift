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
    @State private var testYear6 = SpellingTestMetadata(questions:WordsData().allWordsYear6)
    @State private var testYear5 = SpellingTestMetadata(questions:WordsData().allWordsYear5)
    @State private var testLeo = SpellingTestMetadata(questions:RemoteConfigManager.shared.leoTabItemWordList)
    @State private var testUnoProd = SpellingTestMetadata(questions:RemoteConfigManager.shared.firsttabItemWordList)
    @State private var testUno = SpellingTestMetadata(questions:WordsData().testDataShort)
    @State private var resultsTest = SpellingTestMetadata(questions: WordsData().testDataShort)
    @State private var learningTest = SpellingTestMetadata(questions: RemoteConfigManager.shared.firsttabItemWordList)
    @State private var wordsNotMastered = SpellingTestMetadata(questions: WordsData().wordsNotMasteredYr5)
    @State private var wordsNotMasteredLeo = SpellingTestMetadata(questions: WordsData().wordsNotMasteredLeo2)
    @State private var wordsLeoLy1 = SpellingTestMetadata(questions: WordsData().wordsLeoLy1)
    @State private var wordsLeoLy2 = SpellingTestMetadata(questions: WordsData().wordsLeoLy2)
    @State private var wordsLeoLy3 = SpellingTestMetadata(questions: WordsData().wordsLeoLy3)

    @State private var wordsNotMasteredYr6 = SpellingTestMetadata(questions: WordsData().wordsNotMasteredYr6)
    
    private var enableTabBarForDebug = false
    @State private var testStatusResultsDebug = TestStatus.reviewing
    @State private var testStatusResultsDebugQuestions: [String] = WordsData().allWordsYear6Part1
    @State private var testStatusResultsDebugAnswers: [String] = WordsData().allWordsYear6Part1DebugResponses
    
    init() {
        if RemoteConfigManager.shared.debugMode {
            resultsTest.answers = ["a", "b"]
            resultsTest.startTest = Date()
            resultsTest.finishTest = Date().addingTimeInterval(60)
            learningTest.answers = Array(repeating: "bla", count: RemoteConfigManager.shared.firsttabItemWordList.count)
            learningTest.testStatus = .learning
        }
    }
    
    var body: some View {
        if RemoteConfigManager.shared.debugMode && enableTabBarForDebug {
            TabView(selection: $selectedTabDebug) {
                LearningView(spellingTestMetadata: learningTest)
                    .tabItem {
                        Text("Learning")
                    }
                
                SelfTestView(spellingTestMetadata: learningTest)
                    .tabItem {
                        Text("Self test")
                    }
                ResultsView(spellingTestMetadata: resultsTest)
                    .tabItem {
                        Text("Results")
                    }
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
                
                
                Button("Crash") {
                    fatalError("Crash was triggered")
                }.tabItem { Text("Crash") }
            }
        }
        else {
            if RemoteConfigManager.shared.introduceTabBar {
                TabView(selection: $tabSelection.selectedTab) {
                    FullTestSequence(spellingTestMetadata: wordsLeoLy1)
                        .tabItem { Image(systemName: "1.circle"); Text("Ly1") }.tag(0)
                    FullTestSequence(spellingTestMetadata: wordsLeoLy2)
                        .tabItem { Image(systemName: "2.circle"); Text("Ly2") }.tag(1)
                    FullTestSequence(spellingTestMetadata: wordsLeoLy3)
                        .tabItem { Image(systemName: "3.circle"); Text("Ly3") }.tag(2)
                    FullTestSequence(spellingTestMetadata: testYear6)
                        .tabItem { Image(systemName: "4.circle"); Text("Year 6 Final") }.tag(3)
                    FullTestSequence(spellingTestMetadata: testYear5)
                        .tabItem { Image(systemName: "5.circle"); Text("Year 5 All") }.tag(4)
                    if RemoteConfigManager.shared.yearViewToggle {
                        YearViewProgress()
                            .tabItem { Image(systemName: "3.circle"); Text("Progress") }.tag(5)
                    }
                }
                .font(.subheadline.weight(.heavy))
                .accentColor(Color.white)
                .onAppear {
         
             
                    let tabBarAppearance = UITabBarAppearance()

                    tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.darkGray
                    tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                        .foregroundColor: UIColor.lightGray,
                        .font: UIFont.systemFont(ofSize: 14, weight: .medium)
                    ]
                    
                    tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
                    tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                        .foregroundColor: UIColor.white,
                        .font: UIFont.systemFont(ofSize: 14, weight: .bold)
                    ]
                    
                    tabBarAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                    let tabBar = UITabBar.appearance()
                    tabBar.standardAppearance = tabBarAppearance

                    if #available(iOS 15.0, *) {
                        tabBar.scrollEdgeAppearance = tabBarAppearance
                    }
                }
            }
            else {
                FullTestSequence(spellingTestMetadata: testFull)
            }
        }
    }
}
