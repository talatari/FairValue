//
//  MethodSelectionTVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 13.11.2021.
//

import UIKit

class MethodSelectionTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayAgreementIfNeeded()
    }
    
    var methods = [
        (name: "Дисконтирование денежных потоков", segue: "discountedCashFlow"),
        (name: "Сравнительный подход", segue: "comparativeApproach")
    ]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return methods.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Выберите метод расчёта"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MethodCell", for: indexPath)
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.textLabel?.text = methods[indexPath.row].name
        return cell
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: methods[indexPath.row].segue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// MARK: Private Methods

private extension MethodSelectionTVC {
    func displayAgreementIfNeeded() {
        
        guard !Settings.shared.currentSettings.stateSwitchAgreement else {
            return
        }
        
        performSegue(withIdentifier: "PresentAgreementSegue", sender: self)
        
    }
}
