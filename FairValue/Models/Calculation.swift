//
//  Calculation.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import Foundation


protocol calculation {
    func checkParameters(betaParameter: Double?, divParameter: Double?) -> String
    func calcFairValue(betaParameter: Double, divParameter: Double) -> Double
}

class calculationImp: calculation {
    
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
    
}
