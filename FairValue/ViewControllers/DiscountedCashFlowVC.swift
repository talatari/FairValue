//
//  DiscountedCashFlowVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class DiscountedCashFlowVC: UIViewController, UITextFieldDelegate {

    private enum Currency: Int {
        case usd
        case rub
    }
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
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
    }
    
    // функция подготовки и проверки параметров перед расчётом
    @IBAction func calcFairValue(_ sender: UIButton) {
        // скрываем клавиатуру, если нажата кнопка Рассчитать
        view.endEditing(true)
        
        // заменяем запятую на точку, так как "0,1" воспринимается как "1.0", а не "0.1"
        let beta = betaParameter.text!.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        let div = divParameter.text!.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        // задаём значения которые могут содержаться в наших полях ввода
        let allowedValues = CharacterSet(charactersIn: ".0123456789")
        // пересобираем переменные по нашему набору значений
        let cleanedBeta = beta.components(separatedBy: allowedValues.inverted).joined()
        let cleanedDiv = div.components(separatedBy: allowedValues.inverted).joined()
        
        let betaParameter: Double? = Double(cleanedBeta)
        let divParameter: Double? = Double(cleanedDiv)
        
        let result = checkParameters(betaParameter: betaParameter, divParameter: divParameter)
        
        if result == "ok" {
            let resultFairValue = FairValue.calcFairValue(betaParameter: betaParameter!, divParameter: divParameter!)
            resultLabel.textColor = UIColor.systemGreen
            resultLabel.text = String(resultFairValue)
        } else {
            resultLabel.textColor = UIColor.red
            resultLabel.text = String(result)
        }
        
    }
    
     
    // TODO: понять где вызывать данную функцию. просто так не работает.
    // по идее, нужно подписаться на события данного объекта.
    // суть функции - проверяем количество введённых точек и запятых
    // и припятствовать вводу больше одного разделителя
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        //let dotsCount = betaParameter.text!.componentsSeparatedByString(".").count - 1
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

    
}
