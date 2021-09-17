//
//  Calculation.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import Foundation
/// Функция расчёта справедливой стоимости актива по методу Дисконтирования Денежных Средств
/// Принимает два параметра и на основании заданых констант производит расчё по формуле
/// Возвращая стоимость актива в той валюте, в которой был произведён расчёт
func calcFairValue(betaParameter: Double, divParameter: Double) -> Double {
    
    // TODO: вынести формулу в отдельную функцию
    if Settings.shared.currentSettings.stateTypeCurrency {
        let base = Settings.shared.currentSettings.baseRUB
        let riskPrem = Settings.shared.currentSettings.riskPremRUB
        let infl = Settings.shared.currentSettings.inflRUB
        
        return calculationDFC(betaParameter: betaParameter, divParameter: divParameter, base: base, riskPrem: riskPrem, infl: infl)
    } else {
        let base = Settings.shared.currentSettings.baseUSA
        let riskPrem = Settings.shared.currentSettings.riskPremUSA
        let infl = Settings.shared.currentSettings.inflUSA
        
        return calculationDFC(betaParameter: betaParameter, divParameter: divParameter, base: base, riskPrem: riskPrem, infl: infl)
    }
    
}

func calculationDFC(betaParameter: Double, divParameter: Double, base: Double, riskPrem: Double, infl: Double) -> Double {
    let ocenka = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
    return round(ocenka * 100) / 100
}

