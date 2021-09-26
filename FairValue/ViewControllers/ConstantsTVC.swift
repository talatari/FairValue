//
//  ConstantsTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 20.09.2021.
//

import UIKit

class ConstantsTVC: UITableViewController {

    // MARK: Outlets
    
    //@IBOutlet weak var baseConstant: UITextField!
    //@IBOutlet weak var riskPremConstant: UITextField!
    //@IBOutlet weak var inflConstant: UITextField!
    
    @IBOutlet weak var baseConstant: UITextField!
    @IBOutlet weak var riskPremConstant: UITextField!
    @IBOutlet weak var inflConstant: UITextField!
    
    // MARK: VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: написать функцию, которая будет наполнять нужными значениями
        
        // в зависимости от того в какое положение выставлен переключатель валют
        // считываем значения констант из UserDefaults
        if Settings.shared.currentSettings.stateTypeCurrency {
            baseConstant.text = String(Settings.shared.currentSettings.baseRUB)
            riskPremConstant.text = String(Settings.shared.currentSettings.riskPremRUB)
            inflConstant.text = String(Settings.shared.currentSettings.inflRUB)
        } else {
            baseConstant.text = String(Settings.shared.currentSettings.baseUSA)
            riskPremConstant.text = String(Settings.shared.currentSettings.riskPremUSA)
            inflConstant.text = String(Settings.shared.currentSettings.inflUSA)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkConstants()
    }
    
    
    
    // переопределение метода позволяющего сворачивать клавиатуру при нажатии
    // по любому элементу на ViewController кроме UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with:event)
    }
    
    // проверка констант на изменение и сохрение, если такие есть
    func checkConstants() {
        let baseConstantRUB = String(Settings.shared.currentSettings.baseRUB)
        let riskPremConstantRUB = String(Settings.shared.currentSettings.riskPremRUB)
        let inflConstantRUB = String(Settings.shared.currentSettings.inflRUB)
        
        let baseConstantUSA = String(Settings.shared.currentSettings.baseUSA)
        let riskPremConstantUSA = String(Settings.shared.currentSettings.riskPremUSA)
        let inflConstantUSA = String(Settings.shared.currentSettings.inflUSA)
        
        if Settings.shared.currentSettings.stateTypeCurrency {
            if baseConstant.text! != baseConstantRUB {
                Settings.shared.currentSettings.baseRUB = Double(baseConstant.text!) ?? Double(baseConstantRUB)!
            }
            if riskPremConstant.text! != riskPremConstantRUB {
                Settings.shared.currentSettings.riskPremRUB = Double(riskPremConstant.text!) ?? Double(riskPremConstantRUB)!
            }
            if inflConstant.text! != inflConstantRUB {
                Settings.shared.currentSettings.inflRUB = Double(inflConstant.text!) ?? Double(inflConstantRUB)!
            }
        } else {
            if baseConstant.text! != baseConstantUSA {
                Settings.shared.currentSettings.baseUSA = Double(baseConstant.text!) ?? Double(baseConstantUSA)!
            }
            if riskPremConstant.text! != riskPremConstantUSA {
                Settings.shared.currentSettings.riskPremUSA = Double(riskPremConstant.text!) ?? Double(riskPremConstantUSA)!
            }
            if inflConstant.text! != inflConstantUSA {
                Settings.shared.currentSettings.inflUSA = Double(inflConstant.text!) ?? Double(inflConstantUSA)!
            }
        }
    }
    
}