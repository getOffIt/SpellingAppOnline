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
//    private var questionsFull: [String] {get {RemoteConfigManager.shared.firsttabItemWordList}}
        private var questionsFull = WordsData().testDataShort
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
                if (RemoteConfigManager.shared.sharingResultsEnabled) {
                    ShareView(content: ResultsView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull), caption: "My Results")
                        .tabItem {
                            Image(systemName: "1.circle")
                            Text(remoteConfigLocal.firsttabItemText)
                        }
                        .tag(0)
                }
                else {
                    ResultsView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                        .tabItem {
                            Image(systemName: "1.circle")
                            Text(remoteConfigLocal.firsttabItemText)
                        }
                        .tag(0)
                }
            case .learning:
                Text("Spelling Test")
                LearningView(testStatus: $testStatusFull, questions: questionsFull, answers: $answersFull)
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text(remoteConfigLocal.firsttabItemText)
                    }
                    .tag(0)
            }
            
//            switch testStatusSmall {
//            case .spelling:
//                SelfTestView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text(remoteConfigLocal.secondTabItemText) }
//                    .tag(1)
//            case .reviewing:
//                ResultsView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text(remoteConfigLocal.secondTabItemText)
//                    }
//                    .tag(1)
//                
//            case .learning:
//                SelfTestView(testStatus: $testStatusSmall, questions: questionsSmall, answers: $answersSmall)
//                    .tabItem {
//                        Image(systemName: "2.circle")
//                        Text(remoteConfigLocal.secondTabItemText)
//                    }
//                    .tag(1)
//            }
            ShareView(content: CardView(imageName: "checkmark"), caption: "My Results")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Test")
                }
                .tag(2)

        }
    }
}

fileprivate struct CardView: View {
    let imageName: String
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text(imageName)
            Image(systemName: imageName)
        }
        .foregroundStyle(Color.red)
        .font(.system(size: 20, weight: .bold))
        .padding(.vertical, 50)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.red.opacity(0.1))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 3))
        )
        
    }
}
