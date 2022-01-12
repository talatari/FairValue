//
//  Calculation.swift
//  FairValue
//
//  Created by Tsaplin-SO on 09.01.2022.
//

import Foundation


class CalculationCA {
    
    public static let shared = CalculationCA()
    
    // Функция расчёта справедливой стоимости актива по методу Сравнительного Подхода
    func calcComparativeApproach(YearlyProfit: Double,
                                 Сapitalization: Double,
                                 CurrentMarketPrice: Double,
                                 TargetPE: Double) -> Double {
        
        let result = CurrentMarketPrice * TargetPE / (Сapitalization / YearlyProfit)
        
        return round(result * 10) / 10
    }
    
}
