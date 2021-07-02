//
//  SelectModeView.swift
//  Car Info Tracker
//
//  Created by Marco Marinò on 02/07/21.
//

import UIKit

class SelectModeView {
    
    private let collectionViewController: UICollectionViewController
    
    internal func setupMosaicCollectionView() {
        // create an instance of the cv layout
        let mosaicLayout = MosaicMenuLayout()
        
        // init
        collectionViewController.collectionView = UICollectionView(frame: collectionViewController.view.bounds, collectionViewLayout: mosaicLayout)
        
        // properties
        collectionViewController.collectionView.backgroundColor = .white
        collectionViewController.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewController.collectionView.alwaysBounceVertical = true
        collectionViewController.collectionView.indicatorStyle = .default
        collectionViewController.collectionView.delegate = collectionViewController
        collectionViewController.collectionView.dataSource = collectionViewController
        
        // register the custom cell
        collectionViewController.collectionView.register(ModeCollectionViewCell.self, forCellWithReuseIdentifier: ModeCollectionViewCell.identifier)
        
        // add collection view as subview of this view
        collectionViewController.view.addSubview(collectionViewController.collectionView)
        
        // set the navigation title
        collectionViewController.navigationItem.title = "Car Info Tracker"
    }
    
    init(cv: UICollectionViewController) {
        self.collectionViewController = cv
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
