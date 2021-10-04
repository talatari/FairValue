//
//  FeedBackVC.swift
//  FairValue
//
//  Created by Tsaplin-SO on 15.09.2021.
//

import UIKit
import MessageUI

class FeedBackVC: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var sendFeedBackButton: UIButton!
    @IBOutlet weak var textFeedBack: UITextView!
    @IBOutlet weak var themeFeedBack: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeFeedBack.delegate = self
    }
    
    @IBAction func sendFeedBack(_ sender: UIButton) {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("Can't send email")
        }
    }
    
    
    func configureMailComposer() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        let versionOS = UIDevice.current.systemVersion
        let versionDevice = UIDevice.current.name
        
        var messageFB = self.textFeedBack.text!
        
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["mightyblowgame@gmail.com"])
        mailComposeVC.setSubject(themeFeedBack.text!)
        
        messageFB += "\n\n Версия iOS: " + versionOS
        messageFB += "\n Версия телефона: " + versionDevice
        mailComposeVC.setMessageBody(messageFB, isHTML: false)
        return mailComposeVC
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    
}
