//
//  OnboardingUITests.swift
//  OnboardingUITests
//
//  Created by Kostiantyn Kaniuka on 30.03.2026.
//

import XCTest

final class OnboardingUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testContinueButtonExist() throws {
        let continueButton = app.buttons["Continue"]
        XCTAssertTrue(continueButton.exists, "Continue button should exist")
    }

    func testContinueButtonEnabledAfterSelection() throws {
       
        let continueButton = app.buttons["Continue"]
        XCTAssertFalse(continueButton.isEnabled, "Button should be disabled initially")

       
        let firstCell = app.tables.cells.element(boundBy: 0)
        firstCell.tap()
      
        XCTAssertTrue(continueButton.isEnabled, "Button should be enabled after selection")
    }
}
