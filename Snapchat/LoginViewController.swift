//
//  LoginViewController.swift
//  Snapchat
//
//  Created by Robert Jackson Jr on 6/18/18.
//  Copyright © 2018 Robert Jackson Jr. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
   
    @IBOutlet var topButton: UIButton!
    
    @IBOutlet var bottomButton: UIButton!
    
    var signupMode = false
    
    @IBAction func topTapped(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                if signupMode {
                    //Sign Up
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            self.presentAlert(alert: error.localizedDescription)

                        } else {
                            print("Sign Up was successful :)")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    }
                } else {
                    //Log In
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                                self.presentAlert(alert: error.localizedDescription)
                        } else {
                            print("Log In was successful :)")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                        
                    }
                    
                    }
                    
                    
                }
                
            }
        }
        
        
    func presentAlert(alert:String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if signupMode {
            //Switch to Log In
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            
        } else {
            //Switch to Sign Up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   


}

