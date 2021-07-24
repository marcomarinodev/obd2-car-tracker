//
//  FormButton.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 24/07/21.
//

import UIKit

@IBDesignable
final class FormButton: UIButton {
    
    var title: String!
    var titleColor: UIColor!
    
    var pressTimeInterval: TimeInterval = 1.0
    
    init(frame: CGRect, _ title: String, _ backgroundColor: UIColor, _ tintColor: UIColor) {
        
        super.init(frame: frame)
        self.title = title
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.titleColor = tintColor
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        
        Timer.scheduledTimer(timeInterval: pressTimeInterval, target: self, selector: #selector(IsButtonPressed), userInfo: nil, repeats: true)
    }
    
    @objc func IsButtonPressed() {
        if self.isSelected {
            print("is released")
            self.isSelected = false
        }
    }
    
    func setup() {
        
        // Normal state
        self.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : self.titleColor!]), for: .normal)
        
        // Selected state
        self.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray]), for: .selected)
        
        self.layer.cornerRadius = 2.0
    }
    
}
