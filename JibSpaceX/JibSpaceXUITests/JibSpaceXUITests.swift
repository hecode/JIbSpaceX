//
//  JibSpaceXUITests.swift
//  JibSpaceXUITests
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import XCTest

class JibSpaceXUITests: XCTestCase {
    
    func testHome() {
        let app = XCUIApplication()
        app.launch()
        
        let exp = expectation(description: "Test after 3 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 3.0)
        let navTitleIdentifier = "Filtered Launches"
        let navigationTitleElement = app.navigationBars.matching(identifier: navTitleIdentifier).firstMatch
        XCTAssertTrue(navigationTitleElement.exists)
    }
    
    // Shouldn't rely on strings from apis in actual UI testing

    func testFlow() {
        let app = XCUIApplication()
        app.launch()
        
        let exp = expectation(description: "Test after 3 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        let staticText = app.tables.staticTexts["Paz / Starlink Demo"]
        XCTAssertTrue(staticText.exists)
        staticText.tap()
        
        let navTitleIdentifier = "Rocket Details"
        let navigationTitleElement = app.navigationBars.matching(identifier: navTitleIdentifier).firstMatch
        XCTAssertTrue(navigationTitleElement.exists)
        
        XCTAssertTrue(app.staticTexts["Falcon 9"].exists)
        
        
        let articleNavigationBar = app.navigationBars["Rocket Details"]
        
        XCTAssertTrue(articleNavigationBar.buttons["Filtered Launches"].exists)
        
        articleNavigationBar.buttons["Filtered Launches"].tap()
        app.navigationBars["Filtered Launches"].staticTexts["Filtered Launches"].tap()
        
        let exp2 = expectation(description: "Test after 1 seconds")
        _ = XCTWaiter.wait(for: [exp2], timeout: 1.0)
        
        let navTitleIdentifier2 = "Filtered Launches"
        let navigationTitleElement2 = app.navigationBars.matching(identifier: navTitleIdentifier2).firstMatch
        XCTAssert(navigationTitleElement2.exists)
        
    }
    
    func testScroll() {
        
        let app = XCUIApplication()
        app.launch()
        
        let exp = expectation(description: "Test after 3 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        let tableView = app.descendants(matching: .table).firstMatch
        guard let lastCell = tableView.cells.allElementsBoundByIndex.last else { return }
        
        let swipesLimit = 4
        var count = 0
        
        while lastCell.isHittable == false && count < swipesLimit {
            app.swipeUp()
            count += 1
        }
        
    }
    
    func testRefresh() {
        let app = XCUIApplication()
        app.launch()
        
        let exp = expectation(description: "Test after 3 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 3.0)
        
        let tableView = app.descendants(matching: .table).firstMatch
        let firstCell = tableView.cells.firstMatch
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        start.press(forDuration: 0, thenDragTo: finish)
    }
    
}
