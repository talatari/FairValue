//
//  Calculation.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import Foundation


enum Currency: Int {
    case usd
    case rub
}


// Calculation parameters
extension Currency {
    
    var base: Double {
        switch self {
        case .rub: return Settings.shared.currentSettings.baseRUB
        case .usd: return Settings.shared.currentSettings.baseUSA
        }
    }
    
    var riskPrem: Double {
        switch self {
        case .rub: return Settings.shared.currentSettings.riskPremRUB
        case .usd: return Settings.shared.currentSettings.riskPremUSA
        }
    }
    
    var infl: Double {
        switch self {
        case .rub: return Settings.shared.currentSettings.inflRUB
        case .usd: return Settings.shared.currentSettings.inflUSA
        }
    }
}


public enum CalculationError: Error {
    
    case calculationError(message: String)
}



class FairValueCalculator {
    
    public static let shared = FairValueCalculator()
    
    private func checkParameters(betaParameter: Double, divParameter: Double) throws {
        let constrInput = Settings.shared.currentSettings.constrInput
        var result = "ok"
        
        if betaParameter.isZero {
            result = "Введите Бету "
            if divParameter.isZero  {
                result += "и дивиденды"
            }
        } else {
            if divParameter.isZero {
                result = "Введите дивиденды"
            }
            if betaParameter <= constrInput {
                result = "Введите Бету > " + String(constrInput) + " "
                if divParameter <= 0 {
                    result += "и дивиденды больше 0"
                }
            }
        }
        
        if result != "ok" {
            throw CalculationError.calculationError(message: result)
        }
        
    }
    
    
    // Функция расчёта справедливой стоимости актива по методу Дисконтированного Денежного Потока
    func calcFairValue(betaParameter: Double, divParameter: Double, currency: Currency) throws -> Double {
        
        try checkParameters(betaParameter: betaParameter, divParameter: divParameter)
        
        let riskPrem = currency.riskPrem
        let base = currency.base
        let infl = currency.infl
        
        let result = (divParameter / ((betaParameter * riskPrem + base - infl))) * 100
        return round(result * 10) / 10
    }
    
    
    // Функция расчёта справедливой стоимости актива по методу Сравнительного Подхода
    func calcComparativeApproach(YearlyProfit: Double,
                                 Сapitalization: Double,
                                 CurrentMarketPrice: Double,
                                 TargetPE: Double) -> Double {
        
        let result = CurrentMarketPrice * TargetPE / (Сapitalization / YearlyProfit)
        
        return round(result * 10) / 10
    }
    
    
}
