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
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text, email.isNotEmpty
        
        Auth.auth().signIn(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
    }
    
    @IBAction func guessClicked(_ sender: Any) {
    }
}
