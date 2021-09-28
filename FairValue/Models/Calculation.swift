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
        
        // проверяем параметр Бета, чтобы он не был пустым
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
                result = "Бета меньше " + String(constrInput) + " "
                if divParameter <= 0 {
                    result += "и дивиденды больше 0"
                }
            }
        }
        
        if result != "ok" {
            throw CalculationError.calculationError(message: result)
        }
    }
    
    func calcFairValue(betaParameter: Double, divParameter: Double, currency: Currency) throws -> Double {
        
        try checkParameters(betaParameter: betaParameter, divParameter: divParameter)
        
        let riskPrem = currency.riskPrem
        let base = currency.base
        let infl = currency.infl
        
        var result = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
        result = round(result * 10) / 10
        
        return result
    }
    
    // Функция расчёта справедливой стоимости актива по методу Сравнительного подхода
    func calcComparativeApproach(YearlyProfit: Double,
                                 Сapitalization: Double,
                                 CurrentMarketPrice: Double,
                                 TargetPE: Double) -> Double {
        
        var result = CurrentMarketPrice * TargetPE / (Сapitalization / YearlyProfit)
        result = round(result * 10) / 10
        
        return result
    }
    
/*
class calculation {
    
    // функция проверки параметров перед расчётом
    // возвращает текст уведомления, если параметры не соответствуют ожидаемым значениям
    func checkParameters(betaParameter: Double?, divParameter: Double?) -> String {
        let constrInput = Settings.shared.currentSettings.constrInput
        var result = "ok"
        
        // проверяем параметр Бета, чтобы он не был пустым
        if betaParameter == nil || betaParameter! == 0 {
            result = "Введите Бету "
            if divParameter == nil || divParameter! == 0  {
                result += "и дивиденды"
                return result
            }
            return result
        } else {
            if divParameter == nil || divParameter! == 0 {
                result = "Введите дивиденды"
                return result
            }
            if betaParameter! <= constrInput {
                result = "Бета меньше " + String(constrInput) + " "
                if divParameter! <= 0 {
                    result += "и дивиденды больше 0"
                    return result
                }
                return result
            }
        }
        return result
    }
    
    // Функция расчёта справедливой стоимости актива по методу Дисконтирования Денежных Средств
    // Принимает два параметра и на основании заданых констант производит расчё по формуле
    // Возвращая стоимость актива в той валюте, в которой был произведён расчёт
    func calcFairValue(betaParameter: Double,
                       divParameter: Double) -> Double {
        
        if Settings.shared.currentSettings.stateTypeCurrency {
            let base = Settings.shared.currentSettings.baseRUB
            let riskPrem = Settings.shared.currentSettings.riskPremRUB
            let infl = Settings.shared.currentSettings.inflRUB
            
            var result = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
            result = round(result * 10) / 10
            
            return result
        } else {
            let base = Settings.shared.currentSettings.baseUSA
            let riskPrem = Settings.shared.currentSettings.riskPremUSA
            let infl = Settings.shared.currentSettings.inflUSA
            
            var result = (Double(divParameter) / ((Double(betaParameter) * riskPrem + base - infl))) * 100
            result = round(result * 10) / 10
            
            return result
        }
        
    }
    
    // Функция расчёта справедливой стоимости актива по методу Сравнительного подхода
    func calcComparativeApproach(YearlyProfit: Double,
                                 Сapitalization: Double,
                                 CurrentMarketPrice: Double,
                                 TargetPE: Double) -> Double {
        
        var result = CurrentMarketPrice * TargetPE / (Сapitalization / YearlyProfit)
        result = round(result * 10) / 10
        
        return result
    }
    */
}
