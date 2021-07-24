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
    
        // Create UI
        signUpUI = SignUpView("Sign Up", mainView: self.view)
        
        self.view.addSubview(signUpUI.view)
        
        setTextFieldDelegate()
        
        // Adding handler for buttons inside the signUpView
        signUpUI.signUpWithEmail.addTarget(self, action: #selector(signUpWithEmailHandler), for: UIControl.Event.touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // Sign Up With Email Handler
    @objc func signUpWithEmailHandler() {
        signUpUI.signUpWithEmail.isSelected = !signUpUI.signUpWithEmail.isSelected
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.signUpUI.signUpWithEmail.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.signUpUI.signUpWithEmail.transform = CGAffineTransform.identity
                }
            })
    }
    
    // MARK: - TextFieldDelegate
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        self.view.endEditing(true)
        return false
    
    }
    
    // View is moving up when keyboard will show
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    fileprivate func setTextFieldDelegate() {
        signUpUI.emailField.delegate = self
        signUpUI.repeatEmailField.delegate = self
        signUpUI.passwordField.delegate = self
    }
    
    
}
