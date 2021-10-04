//
//  AgreementVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 10.09.2021.
//

import UIKit

class AgreementVC: UIViewController {

    @IBOutlet weak var switchAgreement: UISwitch!
    
    // MARK: User actions
    
    // sender'ом является объект типа UISwitch - берём состояние его положения
    // и передаем в наше хранилище
    @IBAction func changeStateAgreement(_ sender: UISwitch) {
        Settings.shared.currentSettings.stateSwitchAgreement = sender.isOn
        
        // скрываем модальную View - AgreementVC
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: VC Lifecycle
    
    // этот метод вызывает первым, в тот момент когда ViewController прошёл init()
    // вызывается один раз при создании
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Private methods
    
    private func configure() {
        isModalInPresentation = true
        
        switchAgreement.isOn = Settings.shared.currentSettings.stateSwitchAgreement
    }
    
}

