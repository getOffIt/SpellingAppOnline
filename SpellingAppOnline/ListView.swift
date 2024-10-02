import Foundation
import SwiftUI



struct ListView: View {
    let tests: [SpellingTestMetadata]
    
    var body: some View {
        VStack {
            ForEach(tests, id: \.self) {
                Text($0.testTitle)
            }
        }
    }
}

#Preview {
    
    ListView(tests: [
        SpellingTestMetadata(testTitle: "Autumn term 1", questions: Year2.autumn_term_1),
        SpellingTestMetadata(testTitle: "Autumn term 2", questions: Year2.autumn_term_2),
        SpellingTestMetadata(testTitle: "Autumn term 3", questions: Year2.autumn_term_3)
    ]
    )
}
