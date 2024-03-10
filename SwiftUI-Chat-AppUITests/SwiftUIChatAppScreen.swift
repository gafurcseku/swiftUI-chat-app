import XCTest

class SwiftUIChatAppScreen {
    struct AppScreen {
        let cellButtons:XCUIElement
        let backButton:XCUIElement
        let goQrCode:XCUIElement
        let messageTextField:XCUIElement
        let messageSendButton:XCUIElement
        let backQrCode:XCUIElement
    }
    
    static let appScreen = AppScreen (
        cellButtons: XCUIApplication().buttons["cell_1-cell_1"].firstMatch,
        backButton: XCUIApplication().buttons["back_button"].firstMatch,
        goQrCode: XCUIApplication().buttons["go_qrCode"].firstMatch,
        messageTextField: XCUIApplication().textFields["message_textField"].firstMatch,
        messageSendButton: XCUIApplication().buttons["message_send"].firstMatch,
        backQrCode: XCUIApplication().staticTexts["back_qr_code"].firstMatch
        
    )
    
}

extension SwiftUIChatAppScreen {
    
    static func tapCell() {
        SwiftUIChatAppScreen.appScreen.cellButtons.waitForExistence(timeout: 3)
        SwiftUIChatAppScreen.appScreen.cellButtons.tap()
    }
    
    static func tapQRCode() {
        SwiftUIChatAppScreen.appScreen.goQrCode.waitForExistence(timeout: 3)
        SwiftUIChatAppScreen.appScreen.goQrCode.tap()
    }
    
    static func tapBackQRCode() {
        SwiftUIChatAppScreen.appScreen.backQrCode.waitForExistence(timeout: 3)
        SwiftUIChatAppScreen.appScreen.backQrCode.tap()
    }
    
    static func sendMessage() {
        SwiftUIChatAppScreen.appScreen.messageTextField.tap()
        SwiftUIChatAppScreen.appScreen.messageTextField.typeText("Hi, How are you?")
        SwiftUIChatAppScreen.appScreen.messageSendButton.tap()
    }
    
    static func chatBack() {
        SwiftUIChatAppScreen.appScreen.backButton.press(forDuration: 3)
    }
}

