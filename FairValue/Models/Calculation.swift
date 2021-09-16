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
    
    
    // конвертация Decimal в String и обратно //
    var testD: Decimal = 1.567
    print("Decimal: " + "\(testD)")

    var decimalString = "\(testD)"
    print("String: " + decimalString)
    
    decimalString += "01"
    print("String Modified: " + decimalString)
    
    let formatter = NumberFormatter()
    formatter.generatesDecimalNumbers = true
    formatter.numberStyle = NumberFormatter.Style.decimal
    if let formattedNumber = formatter.number(from: decimalString) as? NSDecimalNumber  {
        testD = formattedNumber as Decimal
        print("Decimal Modified: " + "\(testD)")
    }
    // ------------------------------------ //
    
    
    // TODO: вынести формулу в отдельную функцию
    if Settings.shared.currentSettings.stateTypeCurrency {
        let base = Settings.shared.currentSettings.baseRUB
        let riskPrem = Settings.shared.currentSettings.riskPremRUB
        let infl = Settings.shared.currentSettings.inflRUB
        
        let ocenka = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
        return round(ocenka * 100) / 100
    } else {
        let base = Settings.shared.currentSettings.baseUSA
        let riskPrem = Settings.shared.currentSettings.riskPremUSA
        let infl = Settings.shared.currentSettings.inflUSA
        
        let ocenka = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
        return round(ocenka * 100) / 100
    }
    
}
/*
func calculationDFC() ->  {
    return (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
}
*/
