//
//  SignUpView.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 15/07/21.
//

import UIKit
import GoogleSignIn

class SignUpView {
    
    private var title: String
    
    private var mainView: UIView
    
    public var emailField: UITextField
    
    public var repeatEmailField: UITextField
    
    public var passwordField: UITextField
    
    private var signInWithGoogle: GIDSignInButton
    
    private var signUpWithEmail: UIButton
    
    init(_ title: String, view: inout UIView) {
        self.title = title
        self.mainView = view
        
        self.emailField = UITextField()
        self.repeatEmailField = UITextField()
        self.passwordField = UITextField()
        self.signInWithGoogle = GIDSignInButton()
        self.signUpWithEmail = UIButton()
        
        placeElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: OriginY are hard-coded
    private func placeElements() {
        let superViewMidX = self.mainView.frame.midX
        let superViewWidth = self.mainView.frame.width
        
        let fieldsWidth = CGFloat().computePercent(70, of: superViewWidth)
        let fieldsOriginX = superViewMidX - ( fieldsWidth / 2)
        let fieldsSize = CGSize(width: fieldsWidth, height: 40)
        
        let emailFieldOrigin = CGPoint(x: fieldsOriginX, y: 80)
        let repeatFieldOrigin = CGPoint(x: fieldsOriginX, y: 200)
        let passwordFieldOrigin = CGPoint(x: fieldsOriginX, y: 320)
        let signInGoogleOrigin = CGPoint(x: fieldsOriginX, y: 440)
        let signInEmailOrigin = CGPoint(x: fieldsOriginX, y: 560)
        
        print(emailFieldOrigin)
        print(signInGoogleOrigin)
        
        emailField = UITextField(frame: CGRect(origin: emailFieldOrigin, size: fieldsSize))
        repeatEmailField = UITextField(frame: CGRect(origin: repeatFieldOrigin, size: fieldsSize))
        passwordField = UITextField(frame: CGRect(origin: passwordFieldOrigin, size: fieldsSize))
        signInWithGoogle = GIDSignInButton(frame: CGRect(origin: signInGoogleOrigin, size: fieldsSize))
        signUpWithEmail = UIButton(frame: CGRect(origin: signInEmailOrigin, size: fieldsSize))
        
        assignProperties()
        
        mainView.addSubview(emailField)
        mainView.addSubview(repeatEmailField)
        mainView.addSubview(passwordField)
        mainView.addSubview(signInWithGoogle)
        mainView.addSubview(signUpWithEmail)
    }
    
    fileprivate func assignBackgroundColor() {
        emailField.backgroundColor = .white
        repeatEmailField.backgroundColor = .white
        passwordField.backgroundColor = .white
        signUpWithEmail.backgroundColor = .white
    }
    
    fileprivate func assignTextAttributes() {
        // Color
        emailField.textColor = .black
        repeatEmailField.textColor = .black
        passwordField.textColor = .black
        signUpWithEmail.tintColor = .black
        
        // Hidden characters for password text field
        passwordField.isSecureTextEntry = true
        
        // Disable auto correction
        emailField.autocorrectionType = .no
        repeatEmailField.autocorrectionType = .no
        passwordField.autocorrectionType = .no
    }
    
    fileprivate func assignCornerRadius() {
        emailField.layer.cornerRadius = 2.0
        repeatEmailField.layer.cornerRadius = 2.0
        passwordField.layer.cornerRadius = 2.0
        signUpWithEmail.layer.cornerRadius = 2.0
    }
    
    fileprivate func applyTextFieldsPadding() {
        
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        emailField.leftViewMode = .always
        repeatEmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        repeatEmailField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        passwordField.leftViewMode = .always
    }
    
    fileprivate func assignProperties() {
        
        assignBackgroundColor()
        
        assignTextAttributes()
        
        assignCornerRadius()
        
        applyTextFieldsPadding()
        
    }
    
}
