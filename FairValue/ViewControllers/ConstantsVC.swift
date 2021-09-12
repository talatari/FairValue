//
//  ConstantsVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class ConstantsVC: UIViewController {

    @IBOutlet weak var baseConstant: UITextField!
    @IBOutlet weak var riskPremConstant: UITextField!
    @IBOutlet weak var inflConstant: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Settings.shared.currentSettings.stateTypeCurrency {
            baseConstant.text = String(Settings.shared.currentSettings.baseRUB)
            print(Settings.shared.currentSettings.baseRUB)
            
            riskPremConstant.text = String(Settings.shared.currentSettings.riskPremRUB)
            print(Settings.shared.currentSettings.riskPremRUB)
            
            inflConstant.text = String(Settings.shared.currentSettings.inflRUB)
            print(Settings.shared.currentSettings.inflRUB)
        } else {
            baseConstant.text = String(Settings.shared.currentSettings.baseUSA)
            print(Settings.shared.currentSettings.baseUSA)
            
            riskPremConstant.text = String(Settings.shared.currentSettings.riskPremUSA)
            print(Settings.shared.currentSettings.riskPremUSA)
            
            inflConstant.text = String(Settings.shared.currentSettings.inflUSA)
            print(Settings.shared.currentSettings.inflUSA)
        }
    }
}
