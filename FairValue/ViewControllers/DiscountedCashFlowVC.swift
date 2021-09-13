//
//  DiscountedCashFlowVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class DiscountedCashFlowVC: UIViewController {

    @IBOutlet weak var betaParameter: UITextField!
    @IBOutlet weak var divParameter: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currency: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // переопределение метода позволяющего сворачивать клавиатуру при нажатии
    // по любому элементу на ViewController кроме UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with:event)
    }
    
    // записываем в UserDefaults состояние переключателя валют
    @IBAction func changeCurrency(_ sender: Any) {
        if currency.selectedSegmentIndex == 0 {
            Settings.shared.currentSettings.stateTypeCurrency = false
        }
        if currency.selectedSegmentIndex == 1 {
            Settings.shared.currentSettings.stateTypeCurrency = true
        }
    }
    
    // закрываем клавиатуру при переходе на экран настроек
    @IBAction func closeKeyBoard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // функция подготовки и проверки параметров перед расчётом
    @IBAction func calcFairValue(_ sender: UIButton) {
        
        // задаём значения которые могут содержаться в наших полях ввода
        let allowedValues = CharacterSet(charactersIn: ".0123456789")
        // пересобираем переменные по нашему набору значений
        let cleanedBeta = betaParameter.text!.components(separatedBy: allowedValues.inverted).joined()
        let cleanedDiv = divParameter.text!.components(separatedBy: allowedValues.inverted).joined()
        
        let betaParameter: Double? = Double(cleanedBeta)
        let divParameter: Double? = Double(cleanedDiv)
        
        //let result = checkParameters(betaParameter: betaParameter ?? 0.31, divParameter: divParameter ?? 1)
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
    
    // функция проверки параметров перед расчётом
    // возвращает текст уведомления, если параметры не соответствуют ожидаемым значениям
    func checkParameters(betaParameter: Double?, divParameter: Double?) -> String {
        let constrInput = Settings.shared.currentSettings.constrInput
        var result = "ok"
        

        /*
         
        print(type(of: betaParameter!))
        print(type(of: constrInput))
         
        switch betaParameter! {
        case .. > constrInput:
            result = "Бета меньше " + String(constrInput) + " "
        case nil:
            result = "Введите Бету "
        }
         
        */
        
        
        /*
        // проверяем параметр Бета, чтобы он был выше ограничение 0.3 по формуле
        // чтобы не поймать ошибку деление на 0
        if betaParameter < constrInput {
            result = "Бета меньше " + String(constrInput) + " "
        }
        
        // проверяем параметр Бета, чтобы он не был пустым
        if betaParameter == nil {
            result = "Введите Бету "
        }
        
        // проверяем параметр Дивидендов, чтобы он был больше 0
        // если какое-либо условие по параметру Бета изменила результат,
        // то дописываем изменение. Если нет, то перезаписываем.
        if divParameter < 0 {
            if result == "ok" {
                result = "Дивы меньше 0 "
            } else {
                result += "Дивы меньше 0 "
            }
        }
        
        // проверяем параметр Дивидендов, чтобы он не был равен 0
        // если какое-либо условие по параметру Бета изменила результат,
        // то дописываем изменение. Если нет, то перезаписываем.
        if divParameter == 0 {
            if result == "ok" {
                result = "Дивы = 0 "
            } else {
                result += "Дивы = 0 "
            }
        }
        
        // проверяем параметр Дивидендов, чтобы он не был пустым
        // если какое-либо условие по параметру Бета изменила результат,
        // то дописываем изменение. Если нет, то перезаписываем.
        if divParameter == nil {
            if result == "ok" {
                result = "Введите Дивы "
            } else {
                result += "Введите Дивы "
            }
        }
        
        */
 
        return result
    }
}
