//
//  IdealistaChallengeUITests.swift
//  IdealistaChallengeUITests
//
//  Created by David López on 13/3/25.
//

import XCTest

class RealEstateUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testRealEstateListLoadsAndShowsProperties() {
        
        let realEstateTable = app.tables.firstMatch
        
        XCTAssertTrue(realEstateTable.waitForExistence(timeout: 5.0))
        
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: realEstateTable.cells)
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(realEstateTable.cells.count > 0, "Cells are shown")
    }
    
    func testTapOnPropertyNavigatesToDetailScreen() {
        
        let realEstateTable = app.tables.firstMatch
        
        XCTAssertTrue(realEstateTable.waitForExistence(timeout: 5.0))
        
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: realEstateTable.cells)
        wait(for: [expectation], timeout: 5.0)
        
        let firstCell = realEstateTable.cells.element(boundBy: 0)
        firstCell.tap()
        
        XCTAssertTrue(app.navigationBars.count > 0, "navigation bar is shown")
    }
}
