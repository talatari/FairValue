//
//  FairValueTests.swift
//  FairValueTests
//
//  Created by Tsaplin-SO on 16.09.2021.
//

import XCTest
@testable import FairValue

class FairValueTests: XCTestCase {
    
    var calculation: calculation!

    override func setUpWithError() throws {
        calculation = calculationImp()
    }

    override func tearDownWithError() throws {
        calculation = nil
    }

    func testCalculationFairValue() throws {
        
        let betaParameter = 100.0
        let divParameter = 15.0
        var ValidatedResult: Double
        
        Settings.shared.currentSettings.stateTypeCurrency = true
        ValidatedResult = calculation.calcFairValue(betaParameter: betaParameter, divParameter: divParameter)
        print(ValidatedResult)
        
        Settings.shared.currentSettings.stateTypeCurrency = false
        ValidatedResult = calculation.calcFairValue(betaParameter: betaParameter, divParameter: divParameter)
        print(ValidatedResult)
    
        
    }

}
