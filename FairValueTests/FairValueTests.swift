//
//  FairValueTests.swift
//  FairValueTests
//
//  Created by Tsaplin-SO on 16.09.2021.
//

import XCTest

class FairValueTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(2==2)
    }
    
    func testExample2() throws {
        
        // Arrange
        
        let num: Int = 2
        
        // Act
        
        let result = num * 3
        
        // Assert
        
        XCTAssert(result == 4)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
