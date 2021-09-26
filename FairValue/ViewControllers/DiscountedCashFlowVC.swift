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
    
    // функция проверяет соостояние валюты и приводит положение в соответствие
    private func checkTypeCurrency() {
        if Settings.shared.currentSettings.stateTypeCurrency {
            currency.selectedSegmentIndex = 1
        } else {
            currency.selectedSegmentIndex = 0
        }
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
        
        let betaParameter: Double? = Double(betaParameter.text!)
        let divParameter: Double? = Double(divParameter.text!)
        
        let result = FairValue.calculationImp().checkParameters(betaParameter: betaParameter, divParameter: divParameter)
        
        if result == "ok" {
            let resultFairValue = FairValue.calculationImp().calcFairValue(betaParameter: betaParameter!, divParameter: divParameter!)
            resultLabel.textColor = UIColor.systemGreen
            resultLabel.text = String(resultFairValue)
        } else {
            resultLabel.textColor = UIColor.red
            resultLabel.text = String(result)
        }
    }
  

    
}
