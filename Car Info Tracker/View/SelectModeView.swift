//
//  SelectModeView.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 02/07/21.
//

import UIKit

class SelectModeView {
    
    private let collectionViewController: UICollectionViewController
    private let title: String
    
    internal func setupMosaicCollectionView() {
        // create an instance of the cv layout
        let mosaicLayout = MosaicMenuLayout()
        
        // init
        collectionViewController.collectionView = UICollectionView(frame: collectionViewController.view.bounds, collectionViewLayout: mosaicLayout)
        
        setupCollectionViewProperties()
        
        // register the custom cell
        collectionViewController.collectionView.register(ModeCollectionViewCell.self, forCellWithReuseIdentifier: ModeCollectionViewCell.identifier)
        
        // add collection view as subview of this view
        collectionViewController.view.addSubview(collectionViewController.collectionView)
        
        // setupNavigationController(title: self.title)
        
    }
    
    internal func setupModeCollectionViewCell(_ cell: inout ModeCollectionViewCell, items menuItems: [Mode], indexPath: IndexPath, colorSet: inout Set<UIColor>) {
        
        cell.imageView.image = UIImage(named: menuItems[indexPath.item].imageName)
        cell.textLabel.text = menuItems[indexPath.item].name
        cell.backgroundColor = UIColor().getColor(set: &colorSet)
        
    }
    
    private func setupCollectionViewProperties() {
        // properties
        collectionViewController.collectionView.backgroundColor = UIColor(named: "Color")
        collectionViewController.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewController.collectionView.alwaysBounceVertical = true
        collectionViewController.collectionView.indicatorStyle = .default
        collectionViewController.collectionView.showsVerticalScrollIndicator = false
        collectionViewController.collectionView.showsHorizontalScrollIndicator = false
    }
    
    init(cv: UICollectionViewController, title: String, colorSet: inout Set<UIColor>) {
        
        self.collectionViewController = cv
        self.title = title
        
        colorSet = UIColor.colorSet
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
