//
//  SwiftUIChatAppUITests.swift
//  SwiftUI-Chat-AppUITests
//
//  Created by Md Abdul Gafur on 10/3/24.
//

import XCTest

class SwiftUIChatAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSendMessage() throws {
       
        SwiftUIChatAppScreen.tapCell()
        SwiftUIChatAppScreen.sendMessage()
    }
}
