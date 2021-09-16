//
//  FeedBackVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 15.09.2021.
//

import UIKit
import MessageUI

class FeedBackVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var textFeedBack: UITextView!
    @IBOutlet weak var versionDevice: UITextField!
    @IBOutlet weak var versionOS: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionOS.text = UIDevice.current.systemVersion
        versionDevice.text = UIDevice.current.name
    }
    
    @IBAction func sendTextFeedBack(_ sender: Any) {
        
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("Can't send email")
        }
    }
    
    func configureMailComposer() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["mightyblowgame@gmail.com"])
        mailComposeVC.setSubject("TEST #01")
        mailComposeVC.setMessageBody(self.textFeedBack.text!, isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
