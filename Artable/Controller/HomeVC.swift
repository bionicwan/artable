//
//  ViewController.swift
//  Artable
//
//  Created by Juan Chavez on 5/24/19.
//  Copyright © 2019 Juan Chavez. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            //We are logged in
            loginOutBtn.title = "Logout"
        } else {
            loginOutBtn.title = "Login"
        }
    }
    
    @IBAction func loginOutClicked(_ sender: Any) {
        if let _ = Auth.auth().currentUser {
            //We are logged in
            do {
                try Auth.auth().signOut()
                presentLoginController()
            } catch {
                debugPrint(error.localizedDescription)
            }
        } else {
            presentLoginController()
        }
    }
    
    fileprivate func presentLoginController() {
        let storyboard = UIStoryboard(name: Storyboard.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardId.LoginVC)
        present(controller, animated: true, completion: nil)
    }
}

