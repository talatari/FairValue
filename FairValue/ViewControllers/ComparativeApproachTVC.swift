//
//  ComparativeApproachTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 26.09.2021.
//

import UIKit

class ComparativeApproachTVC: UITableViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var YearlyProfit: UITextField!
    @IBOutlet weak var Сapitalization: UITextField!
    @IBOutlet weak var CurrentMarketPrice: UITextField!
    @IBOutlet weak var TargetPE: UITextField!
    
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
        super.touchesBegan(touches, with:event)
    }
    
    // MARK: User Actions
    
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
        
        let YearlyProfit: Double? = Double(YearlyProfit.text!)
        let Сapitalization: Double? = Double(Сapitalization.text!)
        let CurrentMarketPrice: Double? = Double(CurrentMarketPrice.text!)
        let TargetPE: Double? = Double(TargetPE.text!)
        
        let resultFairValue = FairValue.calculationImp().calcComparativeApproach(YearlyProfit: YearlyProfit!,
                                                                                 Сapitalization: Сapitalization!,
                                                                                 CurrentMarketPrice: CurrentMarketPrice!,
                                                                                 TargetPE: TargetPE!)
        ResultLabel.textColor = UIColor.systemGreen
        ResultLabel.text = String(resultFairValue)

    }

}
