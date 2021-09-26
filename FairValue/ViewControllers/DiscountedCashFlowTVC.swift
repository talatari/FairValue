//
//  DiscountedCashFlowTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 20.09.2021.
//

import UIKit

class DiscountedCashFlowTVC: UITableViewController, UITextFieldDelegate {

//    private enum Currency: Int {
//        case usd
//        case rub
//    }
    
    // MARK: Outlets
    
    @IBOutlet weak var betaParameter: UITextField!
    @IBOutlet weak var divParameter: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currency: UISegmentedControl!
    
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betaParameter.delegate = self
        divParameter.delegate = self
        
        checkTypeCurrency()
        
        // производим расчёт при создании Вида
        calculation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // скрываем клавиатуру при уходе с Вида с расчётами
        view.endEditing(true)
        
        checkTypeCurrency()
    }
    
    // функция проверяет соостояние валюты и приводит положение в соответствие
    private func checkTypeCurrency() {
        if Settings.shared.currentSettings.stateTypeCurrency {
            currency.selectedSegmentIndex = 1
        } else {
            currency.selectedSegmentIndex = 0
        }
    }

    // переопределение метода позволяющего скрывать клавиатуру при нажатии
    // по любому элементу на ViewController кроме UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with:event)
    }
    
    // MARK: User actions
    
    // записываем в UserDefaults состояние переключателя валют
    @IBAction func changeCurrency(_ sender: UISegmentedControl) {
        guard let currency = Currency(rawValue: sender.selectedSegmentIndex) else {
            assertionFailure("Unsupported segment index!!!")
            return
        }
        
        switch currency {
        case .usd:
            Settings.shared.currentSettings.stateTypeCurrency = false
        case .rub:
            Settings.shared.currentSettings.stateTypeCurrency = true
        }
        // пересчитываем значение при переключении типа валюты
        calculation()
    }
    
    // проверяем количество введённых точек/запятых
    // и припятствовать вводу больше одного разделителя в каждом поле
    
    func textField(_ betaParameter: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let dotsCount = betaParameter.text!.components(separatedBy: ".").count - 1
        if dotsCount > 0 && (string == "." || string == ",") {
            return false
        }
        if string == "," {
            betaParameter.text! += "."
            return false
        }
        return true
    }
    
    // TODO: реализовать метод запрета вставки из буфера обмена данных в TextField
    
    // запускаем пересчёт при любых изменениях в текстовых полях ввода параметров
    func textFieldDidChangeSelection(_ textField: UITextField) {
        calculation()
    }
    
    // функция расчёта справедливой стоимости
    private func calculation() {
        
//        let betaParameter: Double? = Double(betaParameter.text!)
//        let divParameter: Double? = Double(divParameter.text!)
//
//        let result = FairValue.calculationImp().checkParameters(betaParameter: betaParameter, divParameter: divParameter)
//
//        if result == "ok" {
//
//            let resultFairValue = FairValue.calculationImp().calcFairValue(betaParameter: betaParameter!, divParameter: divParameter!)
//            resultLabel.textColor = UIColor.systemGreen
//            resultLabel.text = String(resultFairValue)
//        } else {
//            resultLabel.textColor = UIColor.red
//            resultLabel.text = String(result)
//        }
        
        
        ///
        
        guard  let betaParameter = Double(betaParameter.text!),
                let divParameter = Double(divParameter.text!) else {
                    // Show error
                    return
                }
        
        guard let currency = Currency(rawValue: currency.selectedSegmentIndex) else {
            assertionFailure("Unsupported segment index!!!")
            return
        }
        
        let calculator = FairValueCalculator.shared
        
        do {
            let resultFairValue = try calculator.calcFairValue(
                betaParameter: betaParameter, divParameter: divParameter, currency: currency
            )
            
            resultLabel.textColor = UIColor.systemGreen
            resultLabel.text = String(resultFairValue)
        }
        catch let CalculationError.calculationError(message: error) {
            resultLabel.textColor = UIColor.red
            resultLabel.text = error
        }
        catch {
            
        }
        
    }
    



}

//struct ErrorsSet: OptionSet {
//
//    let rawValue: Int
//
//    static let noneBeta = ErrorsSet(rawValue: 1 << 0)
//    static let divBeta = ErrorsSet(rawValue: 1 << 1)
//
//}

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
        
        // If many error types
        
//        var test: ErrorsSet = []
//
//        if betaParameter.isZero {
//            test.insert(.noneBeta)
//        }
//
//        if betaParameter.isZero {
//            test.insert(.divBeta)
//        }
//
//        // If some error types
//
//        let noneBeta = betaParameter.isZero
//        let noneDiv = divParameter.isZero
//
//        switch (noneBeta, noneDiv) {
//        case (false, false): break
//        case (false, true): result = "Введите дивиденды"
//        case (true, false): result = ""
//        case (true, true): result = ""
//        }
//
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
}
