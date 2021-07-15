//
//  SignUpViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 15/07/21.
//

import UIKit

public class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var signUpUI: SignUpView! = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        signUpUI = SignUpView("Sign Up", view: &self.view)
        signUpUI.emailField.delegate = self
        signUpUI.repeatEmailField.delegate = self
        signUpUI.passwordField.delegate = self
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
