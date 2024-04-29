//
//  SpellingAppOnlineUITests.swift
//  SpellingAppOnlineUITests
//
//

import XCTest
import SpellingAppOnline

final class SpellingAppOnlineUITests: XCTestCase {

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    @MainActor func testSimpleJourney() {
        let words = [
            "akommodate", // Double consonants
            "apparent"
            ]
        let app = XCUIApplication()
        let typeWordTextField = app.textFields["Type word"]
        snapshot("01AppStartup")
        for word in words {
            typeWordTextField.tap()
            typeWordTextField.typeText(word) // Add text input here
            snapshot("02 \(word) filled")
            XCUIApplication().buttons["Next"].tap()
            
        }
        snapshot("03Results")
        
        XCUIApplication().buttons["Continue to Learn words page"].tap()

        
    }

}
