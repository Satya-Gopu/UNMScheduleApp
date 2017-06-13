//
//  LoginViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 6/7/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginConstraint.constant = -self.view.bounds.height/2
        passwordConstraint.constant = -userName.bounds.height
        usernameConstraint.constant = -userName.bounds.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func logIn(_ sender: Any) {
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.loginConstraint.constant = -self.userName.frame.height
            self.view.layoutIfNeeded()
        }, completion: {completed in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.loginConstraint.constant = 1
                self.passwordConstraint.constant = 0
                self.usernameConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        })
        
    }
    

    

}
