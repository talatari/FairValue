//
//  ComparativeApproachTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 26.09.2021.
//

import UIKit

class ComparativeApproachTVC: UITableViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var CurrentMarketPrice: UITextField!
    @IBOutlet weak var Сapitalization: UITextField!
    @IBOutlet weak var TargetPE: UITextField!
    @IBOutlet weak var YearlyProfit: UITextField!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        YearlyProfit.delegate = self
        Сapitalization.delegate = self
        CurrentMarketPrice.delegate = self
        TargetPE.delegate = self
        
        calculation()
    }

    // переопределение метода позволяющего скрывать клавиатуру при нажатии
    // по любому элементу на ViewController кроме UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: User Actions
    
    // TODO: сделать единый метод проверки для всех View
    // проверяем количество введённых точек/запятых
    // и припятствовать вводу больше одного разделителя в каждом поле
    func textField(_ betaParameter: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        // считаем сколько уже введено символов и проверяем, если действие не стирание
        let leghtCountTF = betaParameter.text!.count
        if string != "" && leghtCountTF >= 7 {
            return false
        }
        
        // подсчитываем сколько уже точек введено в строку
        let dotsCount = betaParameter.text!.components(separatedBy: ".").count - 1
        if dotsCount > 0 && (string == "." || string == ",") {
            return false
        }
        
        // замена запятой на точку
        if string == "," {
            betaParameter.text! += "."
            return false
        }
        
        // если ввели число и введен 0 - убираем 0, записываем число
        if string.isNumber && betaParameter.text! == "0" {
            betaParameter.text! = string
            calculation()
            return false
        }
        return true
    }
    
    // TODO: реализовать метод запрета вставки из буфера обмена данных в TextField
    
    // запускаем пересчёт при любых изменениях в текстовых полях ввода параметров
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // запрещаем оставлять поле пустым
        if textField.text! == "" {
            textField.text! = "0"
        }
        calculation()
    }
    
    // функция расчёта справедливой стоимости
    private func calculation() {
        
        guard
            let YearlyProfit = Double(YearlyProfit.text!),
            let Сapitalization = Double(Сapitalization.text!),
            let CurrentMarketPrice = Double(CurrentMarketPrice.text!),
            let TargetPE = Double(TargetPE.text!)
        else {
            return
        }
        
        let calculator = FairValueCalculator.shared
        
        let resultFairValue = calculator.calcComparativeApproach(YearlyProfit: YearlyProfit,
                                                                                 Сapitalization: Сapitalization,
                                                                                 CurrentMarketPrice: CurrentMarketPrice,
                                                                                 TargetPE: TargetPE)
        ResultLabel.textColor = UIColor.systemGreen
        ResultLabel.text = String(resultFairValue)

    }

}


extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
