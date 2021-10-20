//
//  FairValueTests.swift
//  FairValueTests
//
//  Created by Tsaplin-SO on 16.09.2021.
//

import XCTest
@testable import FairValue

class FairValueTests: XCTestCase {
    
    var calculation: FairValueCalculator!

    override func setUpWithError() throws {
        calculation = FairValueCalculator()
    }

    override func tearDownWithError() throws {
        calculation = nil
    }

    func testCalculationFairValue() throws {
        /*
        let betaParameter = 100.0
        let divParameter = 15.0
        let Currency = 0
        var ValidatedResult: Double
        
        
        ValidatedResult = calculation.calcFairValue(betaParameter: betaParameter,
                                                    divParameter: divParameter,
                                                    currency: Currency(rawValue: Currency.self)
        )
        print(ValidatedResult)
        
        
        ValidatedResult = calculation.calcFairValue(betaParameter: betaParameter,
                                                    divParameter: divParameter,
                                                    currency: Currency(rawValue: Currency.self)
        )
        print(ValidatedResult)
    */
        
    }

}
