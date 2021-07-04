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
    var textLabel = UILabel()

    // var titleLabel = UILabel()
    
    var assetIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViewSetup()
        textLabelSetup()
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.backgroundColor = .black
        // self.backgroundView = UIImageView(image: UIImage(named: "background"))
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
                
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        
        self.contentView.layer.masksToBounds = true
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            //self.contentView.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8039215686, blue: 0.1333333403, alpha: 1).cgColor
            self.layer.shadowColor = #colorLiteral(red: 0.8196078431, green: 0.8039215686, blue: 0.1333333403, alpha: 1).cgColor
        } else {
            self.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        }
        
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    private func imageViewSetup() {
        imageView.frame = CGRect(x: self.bounds.midX - (self.bounds.width / 4), y: self.bounds.midY - (self.bounds.height / 4), width: self.bounds.width / 2, height: self.bounds.height / 2)
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func textLabelSetup() {
        let verticalSpacing: CGFloat = 5.0
        let originY = imageView.frame.origin.y + imageView.frame.height + verticalSpacing
        let originPoint: CGPoint = CGPoint(x: 10, y: originY)
        
        textLabel.frame = CGRect(origin: originPoint, size: CGSize(
                                    width: self.bounds.width - 10,
                                    height: self.bounds.maxY - originY))
        
        textLabel.textColor = #colorLiteral(red: 0.8196078431, green: 0.8039215686, blue: 0.1333333403, alpha: 1)
        textLabel.font = UIFont.systemFont(ofSize: 12.0)
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
