//
//  HeadacheTrackerUITests.swift
//  HeadacheTrackerUITests
//
//  Created by Азат Алекбаев on 17.11.2026.
//

import XCTest

final class HeadacheTrackerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    @MainActor
    func test_saveButtonIsAppeared() throws {
        let app = XCUIApplication()
        app.launch()

        let addButton = app.buttons["plus"]

        let isAppeared = addButton.waitForExistence(timeout: 5)

        XCTAssertTrue(isAppeared, "Кнопка создания формы не появилась")

        addButton.tap()

        let saveButton = app.buttons["Сохранить"]

        let saveButtonAppeared = saveButton.waitForExistence(timeout: 5)
        XCTAssertTrue(saveButtonAppeared, "Кнопка сохранения не появилась")

    }
}
