//
//  ModeCollectionViewCell.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 29/06/21.
//

import UIKit

class ModeCollectionViewCell: UICollectionViewCell {
    
    // cell identifier
    static let identifier = "ModeCollectionViewCell"
    
    // view components
    var imageView = UIImageView()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.red.cgColor,
            UIColor.purple.cgColor,
            UIColor.cyan.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    var assetIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //cellSetup()
        
        imageViewSetup()
        
        self.addSubview(imageView)
        self.backgroundColor = .red
        // self.backgroundView = UIImageView(image: UIImage(named: "background"))
    }
    
    override func layoutSubviews() {
        cellSetup()
    }
    
    private func cellSetup() {
        // A Boolean value that determines whether subviews are confined to the bounds of the view.
        self.clipsToBounds = true
    
        self.layer.cornerRadius = 15.0
        
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
        
        // A Boolean value that determines whether the receiver automatically resizes its subviews when its bounds change.
        self.autoresizesSubviews = true
    }
    
    private func imageViewSetup() {
        imageView.frame = CGRect(x: self.bounds.midX - (self.bounds.width / 4), y: self.bounds.midY - (self.bounds.height / 4), width: self.bounds.width / 2, height: self.bounds.height / 2)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        assetIdentifier = nil
        
    }
    
}
