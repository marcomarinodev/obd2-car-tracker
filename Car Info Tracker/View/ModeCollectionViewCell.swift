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
    
    var imageView = UIImageView()
    var assetIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // A Boolean value that determines whether subviews are confined to the bounds of the view.
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        // A Boolean value that determines whether the receiver automatically resizes its subviews when its bounds change.
        self.autoresizesSubviews = true
        
        // imageView.frame = self.bounds
        imageView.frame = CGRect(x: self.bounds.midX - (self.bounds.width / 4), y: self.bounds.midY - (self.bounds.height / 4), width: self.bounds.width / 2, height: self.bounds.height / 2)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(imageView)
        
        self.backgroundView = UIImageView(image: UIImage(named: "background"))
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
