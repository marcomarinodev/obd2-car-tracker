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
    
    var assetIdentifier: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // background color
        // self.backgroundColor = UIColor().getColor(set: UIColor.colorSet)
        
        
        imageViewSetup()
        textLabelSetup()
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
                
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        
        self.contentView.layer.masksToBounds = true
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            self.layer.shadowColor = UIColor.white.cgColor
        } else {
            self.layer.shadowColor = UIColor.black.cgColor
        }
        
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    private func imageViewSetup() {
        let imageHeight: CGFloat = CGFloat().computePercent(50, of: self.bounds.height)
        let originX = CGFloat().computePercent(20, of: self.bounds.maxX)
        let originY = CGFloat().computePercent(20, of: self.bounds.maxY)
        imageView.frame = CGRect(x: originX, y: originY, width: self.bounds.width - 2*originX, height: imageHeight)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // textLabel frame is based on imageView frame
    private func textLabelSetup() {
        let verticalSpacing: CGFloat = 2.0
        let originY = imageView.frame.origin.y + imageView.frame.height + verticalSpacing
        let originPoint: CGPoint = CGPoint(x: 10, y: originY)
        let screenWidth = UIScreen.main.bounds.width
        
        // if the tile.width is greater than the half of screen size, then reduce the font size percentage
        // as if it were a 2/3 tile (not totally equals)
        let fontSizeRate = (self.bounds.width > (CGFloat().computePercent(80, of: screenWidth))) ? (screenWidth / 1.7) : self.bounds.width
        
        let fontSize: CGFloat = CGFloat().computePercent(13, of: fontSizeRate)
        
        textLabel.frame = CGRect(origin: originPoint, size: CGSize(
                                    width: self.bounds.width - 20,
                                    height: self.bounds.maxY - originY - 10))
        
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        
        textLabel.minimumScaleFactor = 0.5
        textLabel.numberOfLines = 1
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
