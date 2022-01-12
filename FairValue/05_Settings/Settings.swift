//
//  Settings.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import Foundation

enum KeysUserDefaults {
    static let SettingsApp = "SettingsApp"
}

let constraintLenghtTextFieldConstants = 7
let constraintLenghtTextFieldDiscountedCF = 10
let constraintLenghtTextFieldComparativeA = 10

struct SettingsApp: Codable {
    var stateSwitchAgreement: Bool
    var stateTypeCurrency: Bool
    
    var baseRUB: Double
    var riskPremRUB: Double
    var inflRUB: Double
    
    var baseUSA: Double
    var riskPremUSA: Double
    var inflUSA: Double
    
    var constrInput: Double
}


class Settings {
    
    static var shared = Settings()
    
    private let defaultSettings = SettingsApp(stateSwitchAgreement: false,
                                              stateTypeCurrency: false,
                                              
                                              baseRUB: 5.5,
                                              riskPremRUB: 12.0,
                                              inflRUB: 5.0,
                                              
                                              baseUSA: 0.5,
                                              riskPremUSA: 5.5,
                                              inflUSA: 2.0,
                                              
                                              constrInput: 0.3)
    
    var currentSettings: SettingsApp {
        
        get {
            
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.SettingsApp) as? Data {
                return try! PropertyListDecoder().decode(SettingsApp.self, from: data)
            } else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.SettingsApp)
                }
                return defaultSettings
            }
        }

        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.SettingsApp)
            }
            
        }
    }
    
    
}
