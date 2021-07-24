//
//  SignUpView.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 15/07/21.
//

import UIKit
import GoogleSignIn

class SignUpView {
    
    internal var view: UIView
    
    private var title: String
    
    private var mainView: UIView
    
    // public scope because they need the delegate from the caller vc
    public var emailField: UITextField
    
    public var repeatEmailField: UITextField
    
    public var passwordField: UITextField
    
    public var signInWithGoogle: GIDSignInButton
    
    public var signUpWithEmail: FormButton
    
    init(_ title: String, mainView: UIView) {
        self.title = title
        self.mainView = mainView
        
        emailField = UITextField()
        repeatEmailField = UITextField()
        passwordField = UITextField()
        signInWithGoogle = GIDSignInButton()
        signUpWithEmail = FormButton()
        view = UIView()
        
        placeElements(on: &view, withFieldsHeight: 40, withVerticalSpacing: 80)
        
        addSubviews()
        
        view.backgroundColor = .red
        view.layer.cornerRadius = 15.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func placeElements(on superView: inout UIView, withFieldsHeight fieldsHeight: CGFloat, withVerticalSpacing verticalSpacing: CGFloat) {
    
        // super view width
        let superViewWidth = CGFloat().computePercent(90, of: self.mainView.frame.width)
        
        // fields originX and width
        let fieldsWidth = CGFloat().computePercent(80, of: superViewWidth)
        
        let fieldsOriginX = (superViewWidth / 2) - ( fieldsWidth / 2)
        
        // super view height
        let superViewHeight = ((fieldsHeight * 2) * 5)
        
        let fieldsOriginY = CGFloat().computePercent(5, of: superViewHeight)
        
        let fieldsSize = CGSize(width: fieldsWidth, height: fieldsHeight)
        
        // create the super view
        superView = UIView(frame: CGRect(x: self.mainView.frame.midX - (superViewWidth / 2), y: self.mainView.frame.midY - (superViewHeight / 2), width: superViewWidth, height: superViewHeight))
        
        // Computing the origin points
        let emailFieldOrigin = CGPoint(x: fieldsOriginX, y: fieldsOriginY)
        let repeatFieldOrigin = CGPoint(x: fieldsOriginX, y: fieldsOriginY + verticalSpacing)
        let passwordFieldOrigin = CGPoint(x: fieldsOriginX, y: repeatFieldOrigin.y + verticalSpacing)
        let signInGoogleOrigin = CGPoint(x: fieldsOriginX, y: passwordFieldOrigin.y + verticalSpacing)
        let signInEmailOrigin = CGPoint(x: fieldsOriginX, y: signInGoogleOrigin.y + verticalSpacing)
        
        // allocating space having the origin and size previously computed
        emailField = UITextField(frame: CGRect(origin: emailFieldOrigin, size: fieldsSize))
        repeatEmailField = UITextField(frame: CGRect(origin: repeatFieldOrigin, size: fieldsSize))
        passwordField = UITextField(frame: CGRect(origin: passwordFieldOrigin, size: fieldsSize))
        signInWithGoogle = GIDSignInButton(frame: CGRect(origin: signInGoogleOrigin, size: fieldsSize))
        signUpWithEmail = FormButton(frame: CGRect(origin: signInEmailOrigin, size: fieldsSize), "Sign Up", .black, .red)
        
        // assign ui properties to subviews
        assignProperties()
        
    }
    
    fileprivate func addSubviews() {
        view.addSubview(emailField)
        view.addSubview(repeatEmailField)
        view.addSubview(passwordField)
        view.addSubview(signInWithGoogle)
        view.addSubview(signUpWithEmail)
    }
    
    // Subviews properties
    fileprivate func assignProperties() {
        
        assignBackgroundColor()
        
        assignTextAttributes()
        
        assignCornerRadius()
        
        applyTextFieldsPadding()
        
    }
    
    fileprivate func assignBackgroundColor() {
        emailField.backgroundColor = .white
        repeatEmailField.backgroundColor = .white
        passwordField.backgroundColor = .white
    }
    
    fileprivate func assignTextAttributes() {
        // Color
        emailField.textColor = .black
        repeatEmailField.textColor = .black
        passwordField.textColor = .black
        
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
        
    }
    
    fileprivate func applyTextFieldsPadding() {
        
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        emailField.leftViewMode = .always
        repeatEmailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        repeatEmailField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        passwordField.leftViewMode = .always
    }
    
}
