//
//  MethodSelectionVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class MethodSelectionVC: UIViewController {
    
    // этот метод вызывает первым, в тот момент когда ViewController прошёл init()
    // вызывается один раз при создании
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(Settings.shared.currentSettings.stateSwitchAgreement)
        
        
    }
    
    // этот метод вызывается когда ViewController только что отобразился на экране
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        
        // проверяем текущее состояние переключателя с подтверждением о информировании
        let currentStateSwitch = UserDefaults.standard.bool(forKey: String(Settings.shared.currentSettings.stateSwitchAgreement))
        
        //print(currentStateSwitch)
        
        // если переключатель не нажимался, а по умолчанию это так
        // то отображаем модально ViewController с информированием
        if currentStateSwitch == false {
            //AgreementVC.viewDidLoad(AgreementVC)
            //navigationController?.popViewController(animated: true)
        }
        */
        }
    
}



