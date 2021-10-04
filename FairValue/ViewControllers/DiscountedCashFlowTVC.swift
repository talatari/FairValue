//
//  DiscountedCashFlowTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 20.09.2021.
//

import UIKit

class DiscountedCashFlowTVC: UITableViewController, UITextFieldDelegate {
    
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
        calculation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // скрываем клавиатуру при уходе с Вида с расчётами
        view.endEditing(true)
        
        checkTypeCurrency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // пересчитываем после внесения изменений в константы (настройки)
        calculation()
    }
    
    // проверяем соостояние валюты и приводит положение в соответствие
    private func checkTypeCurrency() {
        if Settings.shared.currentSettings.stateTypeCurrency {
            currency.selectedSegmentIndex = 1
        } else {
            currency.selectedSegmentIndex = 0
        }
    }
    
    // TODO: разобраться почему перестал отрабатывать метод
    // переопределение метода позволяющего скрывать клавиатуру при нажатии
    // по любому элементу на ViewController кроме UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: User actions
    
    // записываем в UserDefaults состояние переключателя валют
    @IBAction func changeCurrency(_ sender: UISegmentedControl) {
        // защита от обращения по индексу все диапазона корректных значений
        guard let currency = Currency(rawValue: sender.selectedSegmentIndex) else {
            assertionFailure("Unsupported segment index!")
            return
        }
        
        // TODO: перевести справочник валют с Bool на Int, для возможности масштабирования
        switch currency {
        case .usd:
            Settings.shared.currentSettings.stateTypeCurrency = false
        case .rub:
            Settings.shared.currentSettings.stateTypeCurrency = true
        }
        
        calculation()
    }
    
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
        
        // TODO: заменить на сет данных разрешенных к вводу?
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
        
        //print("\n CALCULATION \n")
        
        guard
            let betaParameter = Double(betaParameter.text!),
            let divParameter = Double(divParameter.text!)
        else {
            return
        }
        
        guard let currency = Currency(rawValue: currency.selectedSegmentIndex) else {
            assertionFailure("Unsupported segment index!")
            return
        }
        
        let calculator = FairValueCalculator.shared
        
        do {
            let resultFairValue = try calculator.calcFairValue(betaParameter: betaParameter,
                                                               divParameter: divParameter,
                                                               currency: currency
            )
            resultLabel.textColor = UIColor.systemGreen
            resultLabel.text = String(resultFairValue)
        }
        catch let CalculationError.calculationError(message: error) {
            resultLabel.textColor = UIColor.red
            resultLabel.text = error
        }
        catch {
            // Для чего этот catch?
        }
        
    }
    


}
