//
//  SignUpViewController.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 15/07/21.
//

import UIKit

public class SignUpViewController: UIViewController {
    
    var signUpUI: SignUpView! = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    
        signUpUI = SignUpView("Sign Up", view: &self.view)
        
        
    }
    
}