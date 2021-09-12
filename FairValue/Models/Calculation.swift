//
//  Calculation.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import Foundation

func calcFairValue(betaParameter: Double, divParameter: Double) -> Double {
    
    //let beta_ru = Double(betaParameterValue!)! * riskPrem + base
    //let ocenka_ru = (Double(divParameterValue!)! / (beta_ru - infl)) * 100
    
    if Settings.shared.currentSettings.stateTypeCurrency {
        let base = Settings.shared.currentSettings.baseRUB
        let riskPrem = Settings.shared.currentSettings.riskPremRUB
        let infl = Settings.shared.currentSettings.inflRUB
        
        let ocenka_ru = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
        return round(ocenka_ru * 100) / 100
    } else {
        let base = Settings.shared.currentSettings.baseUSA
        let riskPrem = Settings.shared.currentSettings.riskPremUSA
        let infl = Settings.shared.currentSettings.inflUSA
        
        let ocenka_ru = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
        return round(ocenka_ru * 100) / 100
    }
}
