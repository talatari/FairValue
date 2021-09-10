//
//  ViewController.swift
//  FairValue
//
//  Created by Tsaplin-SO on 29.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var betaParameter: UITextField!
    @IBOutlet weak var divParameter: UITextField!
    
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var ocenka: UILabel!
    
    @IBOutlet weak var baseField: UITextField!
    @IBOutlet weak var riskPremField: UITextField!
    @IBOutlet weak var inflField: UITextField!
    @IBOutlet weak var constrInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcButton.layer.cornerRadius = 10 // задаём радиус закругления рамки
        calcButton.layer.borderWidth = 2.0 // задаём толщину рамки
        calcButton.layer.borderColor = (UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor // задаём цвет рамки
        calcButton.clipsToBounds = true    // включаем отображение рамки
    }
    


    @IBAction func calc(_ sender: Any) {
    
    }
    
}
