//
//  LoginVC.swift
//  Artable
//
//  Created by Juan Chavez on 6/5/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgorPassClicked(_ sender: Any) {
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty,
            let password = passwordTxt.text, password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                self.activityIndicator.stopAnimating()
                return
            }
            
           self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func guessClicked(_ sender: Any) {
    }
}
