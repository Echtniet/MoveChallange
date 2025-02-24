//
//  CharacterPageViewUITests.swift
//  MoveChallange
//
//  Created by Clinton on 24/02/2025.
//

import XCTest
@testable import MoveChallange

class MoveChallangeCharacterPageUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testSearchBoxInteraction() throws {
        let magnifyingGlass = app.images["magnifyingglass"]

        let textField = app.textFields["Search..."]
        XCTAssertFalse(textField.exists)

        magnifyingGlass.tap()

        XCTAssertTrue(textField.waitForExistence(timeout: 1))


        textField.tap()
        textField.typeText("Product search")


        XCTAssertEqual(textField.value as? String, "Product search")
    }
}
