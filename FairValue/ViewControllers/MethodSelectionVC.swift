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
        
        displayAgreementIfNeeded()
    }

}

// MARK: Private methods

private extension MethodSelectionVC {
    func displayAgreementIfNeeded() {
        guard !Settings.shared.currentSettings.stateSwitchAgreement else {
            return
        }
        
        performSegue(withIdentifier: "PresentAgreementSegue", sender: self)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondViewController = storyboard.instantiateViewController(withIdentifier: "AgreementVC") as UIViewController
//
//        present(secondViewController, animated: true, completion: nil)
        
    }
}
