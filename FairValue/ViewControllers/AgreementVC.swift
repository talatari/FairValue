//
//  AgreementVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class AgreementVC: UIViewController {

    @IBOutlet weak var switchAgreement: UISwitch!
    
    // этот метод вызывает первым, в тот момент когда ViewController прошёл init()
    // вызывается один раз при создании
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // этот метод вызывается когда ViewController только что отобразился на экране
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchAgreement.isOn = Settings.shared.currentSettings.stateSwitchAgreement
    }
    
    // sender'ом является объект типа UISwitch - берём состояние его положения
    // и передаем в наше хранилище
    @IBAction func changeStateAgreement(_ sender: UISwitch) {
        Settings.shared.currentSettings.stateSwitchAgreement = sender.isOn
        // скрываем модальную View - AgreementVC
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

